import Foundation

class TeamDetailViewModel: ObservableObject {
    @Published var fixtures: [MockMatch] = []
    @Published var squad: [Player] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let standing: Standing
    let season: Int
    
    init(standing: Standing, season: Int) {
        self.standing = standing
        self.season = season
    }
    
    func fetchData() {
        self.isLoading = true
        self.errorMessage = nil
        
        // 2025시즌 더미 및 오프라인/API 키 미설정 모드인 경우 모의 데이터 로드
        if season == 2025 || NetworkManager.shared.apiKey == "YOUR_API_KEY_HERE" || NetworkManager.shared.apiKey.isEmpty {
            loadMockData()
            return
        }
        
        let group = DispatchGroup()
        
        // 1. 경기 일정 가져오기
        group.enter()
        NetworkManager.shared.request(endpoint: .fixtures(league: standing.league, season: season, team: standing.id)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    if items.isEmpty {
                        self.generateMockFixtures()
                    } else {
                        self.mapApiFixtures(items)
                    }
                case .failure:
                    self.generateMockFixtures()
                }
                group.leave()
            }
        }
        
        // 2. 선수단 가져오기
        group.enter()
        NetworkManager.shared.request(endpoint: .players(team: standing.id, season: season)) { (result: Result<[PlayerDetailItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    if items.isEmpty {
                        self.generateMockSquad()
                    } else {
                        self.squad = items.compactMap { Player(detailItem: $0) }
                    }
                case .failure:
                    self.generateMockSquad()
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    private func mapApiFixtures(_ items: [FixtureItem]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        self.fixtures = items.compactMap { item -> MockMatch? in
            guard let matchDate = isoFormatter.date(from: item.fixture.date) else { return nil }
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "MM.dd HH:mm"
            let timeString = timeFormatter.string(from: matchDate)
            
            let statusShort = item.fixture.status.short
            var displayStatus = "NS"
            var displayTime = timeString
            
            if ["1H", "2H", "HT", "ET", "P"].contains(statusShort) {
                displayStatus = "LIVE"
                displayTime = item.fixture.status.elapsed.map { "\($0)'" } ?? "LIVE"
            } else if ["FT", "AET", "PEN"].contains(statusShort) {
                displayStatus = "FT"
                displayTime = "종료"
            }
            
            return MockMatch(
                apiId: item.fixture.id,
                homeTeam: KoreanTranslationService.translateTeam(item.teams.home.name),
                awayTeam: KoreanTranslationService.translateTeam(item.teams.away.name),
                homeScore: item.goals.home,
                awayScore: item.goals.away,
                status: displayStatus,
                time: displayTime,
                stadium: item.fixture.venue?.name ?? "경기장",
                league: self.standing.league,
                dayOffset: 0 // 팀 상세 리스트에선 개별 정렬하므로 사용 안 함
            )
        }.sorted { $0.time > $1.time } // 최근 경기가 맨 위로
    }
    
    private func loadMockData() {
        generateMockFixtures()
        generateMockSquad()
        self.isLoading = false
    }
    
    private func generateMockFixtures() {
        // 팀명에 기반한 상대팀 생성
        let opponents = getOpponentTeams()
        let formChars = Array(standing.form ?? "WDWWL")
        
        var mockFixtures: [MockMatch] = []
        
        // 1. 최근 경기 생성 (Form 기반 및 무작위 결과)
        for i in 0..<min(5, formChars.count) {
            let opponent = opponents[i % opponents.count]
            let char = formChars[i]
            
            var homeScore = 0
            var awayScore = 0
            
            switch char {
            case "W", "w":
                homeScore = Int.random(in: 1...3)
                awayScore = homeScore - Int.random(in: 1...2)
            case "D", "d":
                homeScore = Int.random(in: 0...2)
                awayScore = homeScore
            case "L", "l":
                awayScore = Int.random(in: 1...3)
                homeScore = awayScore - Int.random(in: 1...2)
            default:
                homeScore = 1
                awayScore = 1
            }
            
            // 50% 확률로 홈 경기 설정
            let isHome = Bool.random()
            let homeTeamName = isHome ? standing.teamName : opponent
            let awayTeamName = isHome ? opponent : standing.teamName
            let finalHomeScore = isHome ? homeScore : awayScore
            let finalAwayScore = isHome ? awayScore : homeScore
            
            mockFixtures.append(MockMatch(
                homeTeam: homeTeamName,
                awayTeam: awayTeamName,
                homeScore: finalHomeScore,
                awayScore: finalAwayScore,
                status: "FT",
                time: "종료 (\(season).10.\(25 - i))",
                stadium: isHome ? "\(standing.teamName) 홈경기장" : "\(opponent) 경기장",
                league: standing.league,
                dayOffset: 0
            ))
        }
        
        // 2. 예정된 경기 생성 (2경기)
        for i in 1...2 {
            let opponent = opponents[(i + 4) % opponents.count]
            let isHome = Bool.random()
            let homeTeamName = isHome ? standing.teamName : opponent
            let awayTeamName = isHome ? opponent : standing.teamName
            
            mockFixtures.insert(MockMatch(
                homeTeam: homeTeamName,
                awayTeam: awayTeamName,
                homeScore: nil,
                awayScore: nil,
                status: "NS",
                time: "\(season).11.\(10 + i * 7) 14:00",
                stadium: isHome ? "\(standing.teamName) 홈경기장" : "\(opponent) 경기장",
                league: standing.league,
                dayOffset: 0
            ), at: 0)
        }
        
        self.fixtures = mockFixtures
    }
    
    private func generateMockSquad() {
        let keyPlayers = getSquadKeyPlayers()
        var mockSquad: [Player] = []
        
        for (index, name) in keyPlayers.enumerated() {
            let id = standing.id * 1000 + index
            mockSquad.append(Player(
                id: id,
                name: name,
                photo: nil,
                teamName: standing.teamName,
                goals: Int.random(in: 1...12),
                assists: Int.random(in: 0...8),
                shots: Int.random(in: 10...45),
                passes: Int.random(in: 200...800),
                defense: Int.random(in: 5...60)
            ))
        }
        
        // 득점 순으로 정렬
        self.squad = mockSquad.sorted { $0.goals > $1.goals }
    }
    
    private func getOpponentTeams() -> [String] {
        if standing.league == 1 {
            return ["울산 HD", "전북 현대", "포항 스틸러스", "FC 서울", "수원 FC", "김천 상무", "대전 하나 시티즌", "강원 FC", "광주 FC", "대구 FC", "제주 유나이티드", "FC 안양"].filter { $0 != standing.teamName }
        } else {
            return ["수원 삼성", "부산 아이파크", "서울 이랜드", "전남 드래곤즈", "성남 FC", "부천 FC 1995", "충남아산 FC", "김포 FC", "안산 그리너스", "경남 FC"].filter { $0 != standing.teamName }
        }
    }
    
    private func getSquadKeyPlayers() -> [String] {
        let team = standing.teamName
        if team.contains("울산") {
            return ["주민규", "엄원상", "조현우", "아타루", "루빅손", "김영권", "설영우"]
        } else if team.contains("전북") {
            return ["송민규", "백승호", "김진수", "안병준", "홍정호", "문선민"]
        } else if team.contains("서울") {
            return ["일류첸코", "기성용", "조영욱", "임상협", "최준", "린가드"]
        } else if team.contains("포항") {
            return ["완델손", "오베르단", "백성동", "허용준", "신광훈", "황인재"]
        } else if team.contains("대구") {
            return ["세징야", "에드가", "고재현", "홍철", "오승훈"]
        } else if team.contains("수원 FC") {
            return ["이승우", "윤빛가람", "지동원", "안데르손", "정동호"]
        } else if team.contains("인천") {
            return ["무고사", "제르소", "신진호", "이명주", "오반석"]
        } else if team.contains("대전") {
            return ["마사", "주세종", "레안드로", "김승대", "이창근"]
        } else if team.contains("강원") {
            return ["양현준", "김대원", "갈레고", "이상헌", "황문기"]
        } else if team.contains("광주") {
            return ["엄지성", "이순민", "허율", "정호연", "이희균"]
        } else if team.contains("제주") {
            return ["헤이스", "서진수", "구자철", "안태현", "김동준"]
        } else if team.contains("김천") {
            return ["이영재", "김현욱", "강현무", "조영욱", "박상혁"]
        } else if team.contains("수원 삼성") {
            return ["이기제", "김주찬", "아코스티", "카즈키", "양형모"]
        } else if team.contains("부산") {
            return ["라마스", "페신", "이한도", "김찬", "구상민"]
        }
        
        return ["김철수", "이영희", "박민수", "최태양", "정바다"]
    }
}
