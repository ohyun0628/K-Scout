import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredPlayers: [Player] = []
    @Published var recentSearches: [Player] = []
    @Published var selectedPlayer: Player? = nil
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedSeason: Int = 2026 {
        didSet {
            if !searchText.isEmpty {
                searchPlayers(query: searchText)
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var allPlayersDict: [String: String] = [:]
    private var localDatabase: [Player] = []
    
    init() {
        loadRecentSearches()
        loadAllPlayersDict()
        
        // 검색어 입력 시 0.2초 딜레이(Debounce)를 주어 로컬 필터링 우선 수행
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterMockPlayers(with: text)
            }
            .store(in: &cancellables)
    }
    
    // 로컬 검색어 필터링 (최근 검색어 기반)
    func filterMockPlayers(with query: String) {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredPlayers = recentSearches
        } else {
            filteredPlayers = recentSearches.filter { player in
                player.name.localizedCaseInsensitiveContains(query) ||
                player.teamName.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    // 최근 검색어 추가
    func addRecentSearch(_ player: Player) {
        // 이미 존재하면 제거 (맨 앞으로 옮기기 위해)
        recentSearches.removeAll { $0.id == player.id }
        recentSearches.insert(player, at: 0)
        
        // 최대 10개 유지
        if recentSearches.count > 10 {
            recentSearches.removeLast()
        }
        
        saveRecentSearches()
        
        // 검색어가 비어있을 때는 즉시 업데이트
        if searchText.isEmpty {
            filteredPlayers = recentSearches
        }
    }
    
    private func saveRecentSearches() {
        if let encoded = try? JSONEncoder().encode(recentSearches) {
            UserDefaults.standard.set(encoded, forKey: "recentSearches")
        }
    }
    
    func clearRecentSearches() {
        recentSearches.removeAll()
        saveRecentSearches()
        if searchText.isEmpty {
            filteredPlayers = recentSearches
        }
    }
    
    // 로컬 Mock DB 검색
    func searchPlayers(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            self.filteredPlayers = recentSearches
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        // 0.3초 딜레이로 검색 느낌 살리기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isLoading = false
            
            self.filteredPlayers = self.localDatabase.filter { player in
                player.name.contains(trimmed) ||
                player.name.hasPrefix(trimmed) ||
                player.teamName.contains(trimmed)
            }
        }
    }
    
    // 한국어 -> API-Football 영문 한글 매핑 딕셔너리
    private func translateKoreanToEnglish(_ query: String) -> String {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 1. 정확히 일치하는 이름 검색
        if let exactMatch = allPlayersDict[trimmed] {
            return exactMatch
        }
        
        // 유명 선수 우선 검색 배열 (우선순위 부여)
        let popularPlayers = ["주민규", "이승우", "기성용", "세징야", "설영우", "조현우", "무고사", "일류첸코", "송민규", "김영권", "이동경"]
        
        // 2. 유명 선수 중에서 먼저 부분 일치 검색
        for popular in popularPlayers {
            if popular.contains(trimmed), let eng = allPlayersDict[popular] {
                return eng
            }
        }
        
        // 3. 전체 선수 중에서 이름이 해당 글자로 '시작'하는 선수 우선 검색 (예: "김" -> 김주공)
        for (koreanName, englishName) in allPlayersDict {
            if koreanName.hasPrefix(trimmed) {
                return englishName
            }
        }
        
        // 4. 나머지 부분 일치 검색
        for (koreanName, englishName) in allPlayersDict {
            if koreanName.contains(trimmed) {
                return englishName
            }
        }
        
        return trimmed
    }
    
    private func loadAllPlayersDict() {
        // 로컬에 저장된 전체 선수 명단 JSON 파싱
        if let url = Bundle.main.url(forResource: "KLeaguePlayers", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let englishNames = try? JSONDecoder().decode([String].self, from: data) {
            
            for englishName in englishNames {
                let koreanName = KoreanTranslationService.translatePlayer(englishName)
                if koreanName != englishName {
                    allPlayersDict[koreanName] = englishName
                } else {
                    allPlayersDict[englishName] = englishName
                }
            }
        }
        
        // 강제 매핑 덮어쓰기 (기존 유명 선수들 보장)
        let overrides = [
            "주민규": "Min-Kyu Joo",
            "이승우": "Seung-Woo Lee",
            "기성용": "Sung-Yueng Ki",
            "세징야": "Cesinha",
            "설영우": "Young-Woo Seol",
            "조현우": "Hyeon-Woo Jo",
            "무고사": "Mugosa",
            "일류첸코": "Iljutcenko",
            "송민규": "Min-Kyu Song",
            "김영권": "Young-Gwon Kim",
            "이동경": "Dong-Gyeong Lee"
        ]
        
        for (k, v) in overrides {
            allPlayersDict[k] = v
        }
        
        // 임시 로컬 Mock 데이터베이스 생성
        generateMockDatabase()
    }
    
    private func generateMockDatabase() {
        let teams = [
            "울산 HD FC", "전북 현대 모터스", "포항 스틸러스", "수원 FC", "수원 삼성 블루윙즈", "FC 서울",
            "대전 하나 시티즌", "강원 FC", "광주 FC", "대구 FC", "인천 유나이티드", "제주 유나이티드", "김천 상무 FC"
        ]
        
        var idCounter = 10000
        localDatabase = []
        
        for (koreanName, _) in allPlayersDict {
            let randomGoals = Int.random(in: 0...15)
            let randomAssists = Int.random(in: 0...10)
            let randomTeam = teams.randomElement()!
            
            // 기존 유명 선수들의 경우 하드코딩된 사진/팀/스탯을 사용할 수 있지만, 
            // 현재는 간단히 랜덤 데이터를 부여합니다.
            let player = Player(
                id: idCounter,
                name: koreanName,
                photo: nil, // 엠블럼 이니셜 폴백 사용
                teamName: randomTeam,
                goals: randomGoals,
                assists: randomAssists,
                shots: randomGoals * 4,
                passes: randomAssists * 25 + Int.random(in: 100...500),
                defense: Int.random(in: 5...40)
            )
            localDatabase.append(player)
            idCounter += 1
        }
        
        // 이름 기준 가나다순 정렬
        localDatabase.sort { $0.name < $1.name }
    }
    
    private func loadRecentSearches() {
        if let data = UserDefaults.standard.data(forKey: "recentSearches"),
           let decoded = try? JSONDecoder().decode([Player].self, from: data) {
            recentSearches = decoded
        } else {
            recentSearches = []
        }
        filteredPlayers = recentSearches
    }
}

// MARK: - Player API DTO Extension

extension Player {
    init?(detailItem: PlayerDetailItem) {
        guard let stats = detailItem.statistics.first else { return nil }
        self.id = detailItem.player.id
        self.name = KoreanTranslationService.translatePlayer(detailItem.player.name)
        self.photo = detailItem.player.photo
        self.teamName = KoreanTranslationService.translateTeam(stats.team.name)
        
        self.goals = stats.goals?.total ?? 0
        self.assists = stats.goals?.assists ?? 0
        self.shots = stats.shots?.total ?? 0
        self.passes = stats.passes?.total ?? 0
        self.defense = stats.tackles?.total ?? 0
    }
}
