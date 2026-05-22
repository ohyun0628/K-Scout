import Foundation

class RankingViewModel: ObservableObject {
    @Published var standings: [Standing] = []
    @Published var playerRankings: [PlayerRanking] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentSeason: Int = 2026 {
        didSet {
            fetchAllData(season: currentSeason)
        }
    }
    
    // 리그별/구분별 필터 데이터 리턴
    func filteredStandings(forLeague league: Int) -> [Standing] {
        return standings.filter { $0.league == league }.sorted { $0.rank < $1.rank }
    }
    
    func filteredPlayerRankings(forLeague league: Int, type: String) -> [PlayerRanking] {
        return playerRankings.filter { $0.league == league && $0.type == type }.sorted { $0.rank < $1.rank }
    }
    
    func fetchAllData(season: Int) {
        self.isLoading = true
        self.errorMessage = nil
        
        if season == 2026 {
            self.standings = []
            self.playerRankings = []
            self.isLoading = false
            return
        }
        
        if season == 2025 {
            self.standings = DummyData2025.standings
            self.playerRankings = DummyData2025.playerRankings
            self.isLoading = false
            return
        }
        
        let group = DispatchGroup()
        
        // 1. K리그1 순위 패치
        group.enter()
        fetchStandings(league: 1, season: season) {
            group.leave()
        }
        
        // 2. K리그2 순위 패치
        group.enter()
        fetchStandings(league: 2, season: season) {
            group.leave()
        }
        
        // 3. K리그1 득점왕 패치
        group.enter()
        fetchPlayerRankings(league: 1, season: season, type: "goals") {
            group.leave()
        }
        
        // 4. K리그1 도움왕 패치
        group.enter()
        fetchPlayerRankings(league: 1, season: season, type: "assists") {
            group.leave()
        }
        
        // 5. K리그2 득점왕 패치
        group.enter()
        fetchPlayerRankings(league: 2, season: season, type: "goals") {
            group.leave()
        }
        
        // 6. K리그2 도움왕 패치
        group.enter()
        fetchPlayerRankings(league: 2, season: season, type: "assists") {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    private func fetchStandings(league: Int, season: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.request(endpoint: .standings(league: league, season: season)) { (result: Result<[StandingsResponse], NetworkError>) in
            switch result {
            case .success(let responses):
                if responses.isEmpty {
                    // 빈 배열일 때 폴백: Mock 데이터 적용
                    DispatchQueue.main.async {
                        self.standings = self.standings.filter { $0.league != league } + self.getMockStandings(forLeague: league, season: season)
                    }
                } else if let response = responses.first {
                    let mappedStandings = response.league.standings.flatMap { $0 }.map { item in
                        Standing(
                            id: item.team.id,
                            rank: item.rank,
                            teamName: item.team.name,
                            points: item.points,
                            goalsDiff: item.goalsDiff,
                            played: item.all.played,
                            won: item.all.win,
                            draw: item.all.draw,
                            lost: item.all.lose,
                            league: league
                        )
                    }
                    
                    // K리그 스플릿 라운드 특성상 정규 리그와 상/하위 스플릿 그룹이 중복 집계되어 동일 팀 ID가 여러 번 나타날 수 있으므로 ID 기준 중복 제거
                    var uniqueStandings: [Standing] = []
                    var seenIds = Set<Int>()
                    for standing in mappedStandings {
                        if !seenIds.contains(standing.id) {
                            seenIds.insert(standing.id)
                            uniqueStandings.append(standing)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.standings = self.standings.filter { $0.league != league } + uniqueStandings
                    }
                }
            case .failure:
                // 실패 시 폴백: 현재 리그의 Mock 데이터로 대체
                DispatchQueue.main.async {
                    self.standings = self.standings.filter { $0.league != league } + self.getMockStandings(forLeague: league, season: season)
                }
            }
            completion()
        }
    }
    
    private func fetchPlayerRankings(league: Int, season: Int, type: String, completion: @escaping () -> Void) {
        let endpoint: APIEndpoint = (type == "goals") ? .topScorers(league: league, season: season) : .topAssists(league: league, season: season)
        
        NetworkManager.shared.request(endpoint: endpoint) { (result: Result<[PlayerRankingItem], NetworkError>) in
            switch result {
            case .success(let items):
                if items.isEmpty {
                    // 빈 배열일 때 폴백: Mock 데이터 적용
                    DispatchQueue.main.async {
                        self.playerRankings = self.playerRankings.filter { !($0.league == league && $0.type == type) } + self.getMockPlayerRankings(forLeague: league, season: season, type: type)
                    }
                } else {
                    let mappedRankings = items.enumerated().map { (index, item) -> PlayerRanking in
                        let statCount = (type == "goals") ? (item.statistics.first?.goals.total ?? 0) : (item.statistics.first?.assists?.total ?? 0)
                        return PlayerRanking(
                            id: UUID(),
                            rank: index + 1,
                            playerName: item.player.name,
                            teamName: item.statistics.first?.team.name ?? "알 수 없음",
                            statCount: statCount,
                            played: item.statistics.first?.games.appearances ?? 0,
                            league: league,
                            type: type
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self.playerRankings = self.playerRankings.filter { !($0.league == league && $0.type == type) } + mappedRankings
                    }
                }
            case .failure:
                // 실패 시 폴백: Mock 데이터 적용
                DispatchQueue.main.async {
                    self.playerRankings = self.playerRankings.filter { !($0.league == league && $0.type == type) } + self.getMockPlayerRankings(forLeague: league, season: season, type: type)
                }
            }
            completion()
        }
    }
    
    // MARK: - Dynamic Mock Data Generator by Season
    private func getMockStandings(forLeague league: Int, season: Int) -> [Standing] {
        if season >= 2026 {
            if league == 1 {
                return [
                    Standing(id: 101, rank: 1, teamName: "울산 HD FC", points: 35, goalsDiff: 14, played: 15, won: 11, draw: 2, lost: 2, league: 1),
                    Standing(id: 102, rank: 2, teamName: "전북 현대", points: 32, goalsDiff: 11, played: 15, won: 10, draw: 2, lost: 3, league: 1),
                    Standing(id: 103, rank: 3, teamName: "김천 상무", points: 29, goalsDiff: 8, played: 15, won: 9, draw: 2, lost: 4, league: 1),
                    Standing(id: 104, rank: 4, teamName: "포항 스틸러스", points: 28, goalsDiff: 6, played: 15, won: 8, draw: 4, lost: 3, league: 1),
                    Standing(id: 105, rank: 5, teamName: "FC 서울", points: 26, goalsDiff: 4, played: 15, won: 7, draw: 5, lost: 3, league: 1),
                    Standing(id: 106, rank: 6, teamName: "강원 FC", points: 24, goalsDiff: 2, played: 15, won: 7, draw: 3, lost: 5, league: 1),
                    Standing(id: 107, rank: 7, teamName: "대전 하나", points: 21, goalsDiff: 0, played: 15, won: 6, draw: 3, lost: 6, league: 1),
                    Standing(id: 108, rank: 8, teamName: "광주 FC", points: 18, goalsDiff: -2, played: 15, won: 5, draw: 3, lost: 7, league: 1),
                    Standing(id: 109, rank: 9, teamName: "FC 안양", points: 15, goalsDiff: -5, played: 15, won: 4, draw: 3, lost: 8, league: 1),
                    Standing(id: 110, rank: 10, teamName: "인천 유나이티드", points: 14, goalsDiff: -6, played: 15, won: 3, draw: 5, lost: 7, league: 1),
                    Standing(id: 111, rank: 11, teamName: "제주 유나이티드", points: 11, goalsDiff: -10, played: 15, won: 3, draw: 2, lost: 10, league: 1),
                    Standing(id: 112, rank: 12, teamName: "부천 FC 1995", points: 9, goalsDiff: -12, played: 15, won: 2, draw: 3, lost: 10, league: 1)
                ]
            } else {
                return [
                    Standing(id: 201, rank: 1, teamName: "수원 삼성", points: 31, goalsDiff: 10, played: 15, won: 9, draw: 4, lost: 2, league: 2),
                    Standing(id: 202, rank: 2, teamName: "서울 이랜드", points: 28, goalsDiff: 8, played: 15, won: 8, draw: 4, lost: 3, league: 2),
                    Standing(id: 203, rank: 3, teamName: "부산 아이파크", points: 26, goalsDiff: 5, played: 15, won: 7, draw: 5, lost: 3, league: 2),
                    Standing(id: 204, rank: 4, teamName: "전남 드래곤즈", points: 24, goalsDiff: 3, played: 15, won: 6, draw: 6, lost: 3, league: 2),
                    Standing(id: 205, rank: 5, teamName: "성남 FC", points: 21, goalsDiff: 1, played: 15, won: 5, draw: 6, lost: 4, league: 2),
                    Standing(id: 206, rank: 6, teamName: "수원 FC", points: 19, goalsDiff: -2, played: 15, won: 5, draw: 4, lost: 6, league: 2),
                    Standing(id: 207, rank: 7, teamName: "대구 FC", points: 18, goalsDiff: -3, played: 15, won: 4, draw: 6, lost: 5, league: 2),
                    Standing(id: 208, rank: 8, teamName: "충남아산 FC", points: 15, goalsDiff: -5, played: 15, won: 3, draw: 6, lost: 6, league: 2)
                ]
            }
        } else if season == 2025 {
            if league == 1 {
                return [
                    Standing(id: 101, rank: 1, teamName: "전북 현대", points: 75, goalsDiff: 28, played: 38, won: 22, draw: 9, lost: 7, league: 1),
                    Standing(id: 102, rank: 2, teamName: "김천 상무", points: 68, goalsDiff: 19, played: 38, won: 19, draw: 11, lost: 8, league: 1),
                    Standing(id: 103, rank: 3, teamName: "대전 하나", points: 65, goalsDiff: 15, played: 38, won: 18, draw: 11, lost: 9, league: 1),
                    Standing(id: 104, rank: 4, teamName: "포항 스틸러스", points: 62, goalsDiff: 12, played: 38, won: 17, draw: 11, lost: 10, league: 1),
                    Standing(id: 105, rank: 5, teamName: "FC 서울", points: 59, goalsDiff: 8, played: 38, won: 16, draw: 11, lost: 11, league: 1),
                    Standing(id: 106, rank: 6, teamName: "강원 FC", points: 55, goalsDiff: 3, played: 38, won: 15, draw: 10, lost: 13, league: 1),
                    Standing(id: 107, rank: 7, teamName: "FC 안양", points: 51, goalsDiff: -4, played: 38, won: 14, draw: 9, lost: 15, league: 1),
                    Standing(id: 108, rank: 8, teamName: "광주 FC", points: 48, goalsDiff: -6, played: 38, won: 13, draw: 9, lost: 16, league: 1),
                    Standing(id: 109, rank: 9, teamName: "울산 HD FC", points: 46, goalsDiff: -8, played: 38, won: 12, draw: 10, lost: 16, league: 1),
                    Standing(id: 110, rank: 10, teamName: "수원 FC", points: 42, goalsDiff: -12, played: 38, won: 11, draw: 9, lost: 18, league: 1),
                    Standing(id: 111, rank: 11, teamName: "제주 유나이티드", points: 38, goalsDiff: -15, played: 38, won: 9, draw: 11, lost: 18, league: 1),
                    Standing(id: 112, rank: 12, teamName: "대구 FC", points: 35, goalsDiff: -20, played: 38, won: 8, draw: 11, lost: 19, league: 1)
                ]
            } else {
                return [
                    Standing(id: 201, rank: 1, teamName: "인천 유나이티드", points: 69, goalsDiff: 18, played: 36, won: 20, draw: 9, lost: 7, league: 2),
                    Standing(id: 202, rank: 2, teamName: "부천 FC 1995", points: 64, goalsDiff: 13, played: 36, won: 18, draw: 10, lost: 8, league: 2),
                    Standing(id: 203, rank: 3, teamName: "수원 삼성", points: 61, goalsDiff: 10, played: 36, won: 17, draw: 10, lost: 9, league: 2),
                    Standing(id: 204, rank: 4, teamName: "서울 이랜드", points: 58, goalsDiff: 7, played: 36, won: 16, draw: 10, lost: 10, league: 2),
                    Standing(id: 205, rank: 5, teamName: "전남 드래곤즈", points: 53, goalsDiff: 2, played: 36, won: 14, draw: 11, lost: 11, league: 2),
                    Standing(id: 206, rank: 6, teamName: "부산 아이파크", points: 50, goalsDiff: -1, played: 36, won: 13, draw: 11, lost: 12, league: 2),
                    Standing(id: 207, rank: 7, teamName: "성남 FC", points: 45, goalsDiff: -5, played: 36, won: 11, draw: 12, lost: 13, league: 2),
                    Standing(id: 208, rank: 8, teamName: "충남아산 FC", points: 42, goalsDiff: -8, played: 36, won: 10, draw: 12, lost: 14, league: 2)
                ]
            }
        } else {
            // 2024년 및 이전 디폴트 데이터
            if league == 1 {
                return [
                    Standing(id: 101, rank: 1, teamName: "울산 HD FC", points: 33, goalsDiff: 15, played: 15, won: 10, draw: 3, lost: 2, league: 1),
                    Standing(id: 102, rank: 2, teamName: "전북 현대", points: 31, goalsDiff: 12, played: 15, won: 9, draw: 4, lost: 2, league: 1),
                    Standing(id: 103, rank: 3, teamName: "포항 스틸러스", points: 29, goalsDiff: 8, played: 15, won: 8, draw: 5, lost: 2, league: 1),
                    Standing(id: 104, rank: 4, teamName: "수원 FC", points: 25, goalsDiff: 2, played: 15, won: 7, draw: 4, lost: 4, league: 1),
                    Standing(id: 105, rank: 5, teamName: "서울 FC", points: 24, goalsDiff: 3, played: 15, won: 6, draw: 6, lost: 3, league: 1),
                    Standing(id: 106, rank: 6, teamName: "대전 하나", points: 20, goalsDiff: -1, played: 15, won: 5, draw: 5, lost: 5, league: 1),
                    Standing(id: 107, rank: 7, teamName: "강원 FC", points: 16, goalsDiff: -6, played: 15, won: 4, draw: 4, lost: 7, league: 1),
                    Standing(id: 108, rank: 8, teamName: "광주 FC", points: 12, goalsDiff: -10, played: 15, won: 3, draw: 3, lost: 9, league: 1),
                    Standing(id: 109, rank: 9, teamName: "대구 FC", points: 11, goalsDiff: -8, played: 15, won: 2, draw: 5, lost: 8, league: 1),
                    Standing(id: 110, rank: 10, teamName: "인천 유나이티드", points: 10, goalsDiff: -11, played: 15, won: 2, draw: 4, lost: 9, league: 1),
                    Standing(id: 111, rank: 11, teamName: "제주 유나이티드", points: 9, goalsDiff: -12, played: 15, won: 2, draw: 3, lost: 10, league: 1),
                    Standing(id: 112, rank: 12, teamName: "김천 상무", points: 9, goalsDiff: -12, played: 15, won: 1, draw: 6, lost: 8, league: 1)
                ]
            } else {
                return [
                    Standing(id: 201, rank: 1, teamName: "부산 아이파크", points: 31, goalsDiff: 10, played: 15, won: 9, draw: 4, lost: 2, league: 2),
                    Standing(id: 202, rank: 2, teamName: "수원 삼성", points: 29, goalsDiff: 8, played: 15, won: 8, draw: 5, lost: 2, league: 2),
                    Standing(id: 203, rank: 3, teamName: "서울 이랜드", points: 26, goalsDiff: 5, played: 15, won: 7, draw: 5, lost: 3, league: 2),
                    Standing(id: 204, rank: 4, teamName: "전남 드래곤즈", points: 24, goalsDiff: 3, played: 15, won: 6, draw: 6, lost: 3, league: 2),
                    Standing(id: 205, rank: 5, teamName: "성남 FC", points: 20, goalsDiff: 0, played: 15, won: 5, draw: 5, lost: 5, league: 2),
                    Standing(id: 206, rank: 6, teamName: "FC 안양", points: 18, goalsDiff: -2, played: 15, won: 4, draw: 6, lost: 5, league: 2),
                    Standing(id: 207, rank: 7, teamName: "부천 FC 1995", points: 16, goalsDiff: -3, played: 15, won: 3, draw: 7, lost: 5, league: 2),
                    Standing(id: 208, rank: 8, teamName: "충남아산 FC", points: 14, goalsDiff: -5, played: 15, won: 3, draw: 5, lost: 7, league: 2)
                ]
            }
        }
    }
    
    private func getMockPlayerRankings(forLeague league: Int, season: Int, type: String) -> [PlayerRanking] {
        if season == 2025 {
            if league == 1 {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "사바그", teamName: "전북 현대", statCount: 17, played: 34, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "이동경", teamName: "김천 상무", statCount: 14, played: 33, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "일류첸코", teamName: "서울 FC", statCount: 13, played: 35, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "주민규", teamName: "울산 HD", statCount: 12, played: 32, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "무고사", teamName: "인천 유나이티드", statCount: 11, played: 36, league: 1, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "세징야", teamName: "대구 FC", statCount: 9, played: 35, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "이동경", teamName: "김천 상무", statCount: 8, played: 33, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "송민규", teamName: "전북 현대", statCount: 7, played: 34, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "안데르손", teamName: "수원 FC", statCount: 7, played: 35, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "기성용", teamName: "서울 FC", statCount: 6, played: 32, league: 1, type: "assists")
                    ]
                }
            } else {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "제르소", teamName: "인천 유나이티드", statCount: 15, played: 32, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "루페타", teamName: "부천 FC 1995", statCount: 13, played: 33, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "뮬리치", teamName: "수원 삼성", statCount: 11, played: 30, league: 2, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 10, played: 34, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "홍창범", teamName: "부천 FC 1995", statCount: 7, played: 33, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "아코스티", teamName: "수원 삼성", statCount: 6, played: 28, league: 2, type: "assists")
                    ]
                }
            }
        } else if season >= 2026 {
            if league == 1 {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "주민규", teamName: "울산 HD FC", statCount: 9, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "송민규", teamName: "전북 현대", statCount: 8, played: 14, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "조영욱", teamName: "FC 서울", statCount: 7, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "이승우", teamName: "전북 현대", statCount: 6, played: 13, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "엄원상", teamName: "울산 HD FC", statCount: 5, played: 14, league: 1, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "이동경", teamName: "김천 상무", statCount: 6, played: 15, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "린가드", teamName: "FC 서울", statCount: 5, played: 12, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "바코", teamName: "울산 HD FC", statCount: 4, played: 14, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "송민규", teamName: "전북 현대", statCount: 4, played: 14, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "기성용", teamName: "FC 서울", statCount: 3, played: 15, league: 1, type: "assists")
                    ]
                }
            } else {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "뮬리치", teamName: "수원 삼성", statCount: 8, played: 14, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "호난", teamName: "서울 이랜드", statCount: 7, played: 13, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 6, played: 15, league: 2, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 7, played: 15, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "카즈키", teamName: "수원 삼성", statCount: 5, played: 13, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "브루노", teamName: "서울 이랜드", statCount: 4, played: 14, league: 2, type: "assists")
                    ]
                }
            }
        } else {
            if league == 1 {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "주민규", teamName: "울산 HD", statCount: 14, played: 16, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "일류첸코", teamName: "서울 FC", statCount: 11, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "무고사", teamName: "인천 유나이티드", statCount: 10, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "송민규", teamName: "전북 현대", statCount: 8, played: 14, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "이승우", teamName: "수원 FC", statCount: 8, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 6, playerName: "아사니", teamName: "광주 FC", statCount: 7, played: 13, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 7, playerName: "야고", teamName: "강원 FC", statCount: 7, played: 14, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 8, playerName: "이상헌", teamName: "강원 FC", statCount: 6, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 9, playerName: "김현", teamName: "수원 FC", statCount: 6, played: 15, league: 1, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 10, playerName: "구스타보", teamName: "대구 FC", statCount: 5, played: 14, league: 1, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "세징야", teamName: "대구 FC", statCount: 7, played: 15, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "설영우", teamName: "울산 HD", statCount: 6, played: 14, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "기성용", teamName: "서울 FC", statCount: 5, played: 15, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "백승호", teamName: "전북 현대", statCount: 5, played: 13, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "안데르손", teamName: "수원 FC", statCount: 4, played: 15, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 6, playerName: "이동경", teamName: "울산 HD", statCount: 4, played: 12, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 7, playerName: "송민규", teamName: "전북 현대", statCount: 4, played: 14, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 8, playerName: "이명주", teamName: "인천 유나이티드", statCount: 3, played: 15, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 9, playerName: "엄원상", teamName: "울산 HD", statCount: 3, played: 14, league: 1, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 10, playerName: "조영욱", teamName: "서울 FC", statCount: 3, played: 15, league: 1, type: "assists")
                    ]
                }
            } else {
                if type == "goals" {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "조나탄", teamName: "FC 안양", statCount: 12, played: 15, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "루페타", teamName: "부천 FC 1995", statCount: 9, played: 14, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 8, played: 15, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 7, played: 14, league: 2, type: "goals"),
                        PlayerRanking(id: UUID(), rank: 5, playerName: "주닝요", teamName: "충남아산 FC", statCount: 6, played: 15, league: 2, type: "goals")
                    ]
                } else {
                    return [
                        PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 8, played: 15, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 2, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 6, played: 14, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 3, playerName: "주닝요", teamName: "충남아산 FC", statCount: 5, played: 15, league: 2, type: "assists"),
                        PlayerRanking(id: UUID(), rank: 4, playerName: "카이온", teamName: "부산 아이파크", statCount: 4, played: 13, league: 2, type: "assists")
                    ]
                }
            }
        }
    }
}
