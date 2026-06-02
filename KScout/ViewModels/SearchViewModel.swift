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
    
    // API 실시간 선수 명 검색 호출
    func searchPlayers(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            self.filteredPlayers = recentSearches
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        let englishQuery = translateKoreanToEnglish(trimmed)
        let group = DispatchGroup()
        var fetchedPlayers: [Player] = []
        
        // K리그 1 검색
        group.enter()
        NetworkManager.shared.request(endpoint: .playerSearch(query: englishQuery, league: 1, season: selectedSeason)) { (result: Result<[PlayerDetailItem], NetworkError>) in
            if case .success(let items) = result {
                let players = items.compactMap { Player(detailItem: $0) }
                fetchedPlayers.append(contentsOf: players)
            }
            group.leave()
        }
        
        // K리그 2 검색
        group.enter()
        NetworkManager.shared.request(endpoint: .playerSearch(query: englishQuery, league: 2, season: selectedSeason)) { (result: Result<[PlayerDetailItem], NetworkError>) in
            if case .success(let items) = result {
                let players = items.compactMap { Player(detailItem: $0) }
                fetchedPlayers.append(contentsOf: players)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            if fetchedPlayers.isEmpty {
                // API 결과가 없거나 통신 실패 시 로컬 검색으로 자연스러운 전환
                self.filterMockPlayers(with: trimmed)
            } else {
                // 중복 제거
                var uniquePlayers: [Player] = []
                for p in fetchedPlayers {
                    if !uniquePlayers.contains(where: { $0.id == p.id }) {
                        uniquePlayers.append(p)
                    }
                }
                self.filteredPlayers = uniquePlayers
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
