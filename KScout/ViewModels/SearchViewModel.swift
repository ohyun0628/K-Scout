import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredPlayers: [Player] = []
    @Published var recentSearches: [Player] = []
    @Published var selectedPlayer: Player? = nil
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private var allPlayersDict: [String: String] = [:]
    
    init() {
        loadRecentSearches()
        loadAllPlayersDict()
        
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterMockPlayers(with: text)
            }
            .store(in: &cancellables)
    }
    
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
    
    func addRecentSearch(_ player: Player) {
        recentSearches.removeAll(where: { $0.id == player.id })
        recentSearches.insert(player, at: 0)
        
        if recentSearches.count > 10 {
            recentSearches.removeLast()
        }
        
        saveRecentSearches()
        
        if searchText.isEmpty {
            filteredPlayers = recentSearches
        }
    }
    
    private func saveRecentSearches() {
        if let encoded = try? JSONEncoder().encode(recentSearches) {
            UserDefaults.standard.set(encoded, forKey: "recentSearches")
        }
    }
    
    func removeRecentSearch(_ player: Player) {
        recentSearches.removeAll(where: { $0.id == player.id })
        saveRecentSearches()
        if searchText.isEmpty {
            filteredPlayers = recentSearches
        }
    }
    
    func clearRecentSearches() {
        recentSearches.removeAll()
        saveRecentSearches()
        if searchText.isEmpty {
            filteredPlayers = recentSearches
        }
    }
    
    func searchPlayers(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            self.filteredPlayers = recentSearches
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        let englishQueries = translateKoreanToEnglish(trimmed)
        let group = DispatchGroup()
        var allFetchedItems: [PlayerDetailItem] = []
        let queue = DispatchQueue(label: "com.kscout.searchQueue")
        
        let targetLeagues = [1, 2]
        
        if MockPlayerService.shared.useMockData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let mockItems = MockPlayerService.shared.getMockPlayerDetail()
                allFetchedItems.append(contentsOf: mockItems)
                self.processFetchedItems(allFetchedItems)
            }
            return
        }
        
        for englishQuery in englishQueries {
            for league in targetLeagues {
                group.enter()
                NetworkManager.shared.request(endpoint: .playerSearch(query: englishQuery, league: league, season: nil)) { (result: Result<[PlayerDetailItem], NetworkError>) in
                    if case .success(let items) = result {
                        queue.async { allFetchedItems.append(contentsOf: items) }
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.processFetchedItems(allFetchedItems)
        }
    }
    
    private func processFetchedItems(_ allFetchedItems: [PlayerDetailItem]) {
        self.isLoading = false
        
        if allFetchedItems.isEmpty {
            self.errorMessage = "검색 결과와 일치하는 선수가 없습니다."
            self.filteredPlayers = []
        } else {
            var aggregatedDict: [Int: PlayerDetailItem] = [:]
            
            for item in allFetchedItems {
                let id = item.player.id
                if var existing = aggregatedDict[id] {
                    let kLeagueStats = item.statistics.filter { stat in
                        let isKLeague = (stat.league?.id == 292 || stat.league?.id == 293)
                        let isTargetSeason = [2022, 2023, 2024].contains(stat.league?.season ?? 0)
                        return isKLeague && isTargetSeason
                    }
                    
                    if !kLeagueStats.isEmpty, var existingStat = existing.statistics.first {
                        var totalGoals = existingStat.goals?.total ?? 0
                        var totalAssists = existingStat.goals?.assists ?? 0
                        var totalShots = existingStat.shots?.total ?? 0
                        var totalPasses = existingStat.passes?.total ?? 0
                        var totalTackles = existingStat.tackles?.total ?? 0
                        
                        for stat in kLeagueStats {
                            totalGoals += (stat.goals?.total ?? 0)
                            totalAssists += (stat.goals?.assists ?? 0)
                            totalShots += (stat.shots?.total ?? 0)
                            totalPasses += (stat.passes?.total ?? 0)
                            totalTackles += (stat.tackles?.total ?? 0)
                        }
                        
                        existingStat.goals = GoalDetailedStats(total: totalGoals, assists: totalAssists)
                        existingStat.shots = ShotDetailedStats(total: totalShots)
                        existingStat.passes = PassDetailedStats(total: totalPasses)
                        existingStat.tackles = TackleDetailedStats(total: totalTackles)
                        
                        if existingStat.league?.name.contains("Cup") == true, let validStat = kLeagueStats.last {
                            existingStat.team = validStat.team
                            existingStat.league = validStat.league
                        }
                        
                        existing.statistics[0] = existingStat
                        aggregatedDict[id] = existing
                    }
                } else {
                    var newItem = item
                    let kLeagueStats = item.statistics.filter { stat in
                        let isKLeague = (stat.league?.id == 292 || stat.league?.id == 293)
                        let isTargetSeason = [2022, 2023, 2024].contains(stat.league?.season ?? 0)
                        return isKLeague && isTargetSeason
                    }
                    
                    if let firstValid = kLeagueStats.first {
                        var combinedStat = firstValid
                        var totalGoals = 0
                        var totalAssists = 0
                        var totalShots = 0
                        var totalPasses = 0
                        var totalTackles = 0
                        
                        for stat in kLeagueStats {
                            totalGoals += (stat.goals?.total ?? 0)
                            totalAssists += (stat.goals?.assists ?? 0)
                            totalShots += (stat.shots?.total ?? 0)
                            totalPasses += (stat.passes?.total ?? 0)
                            totalTackles += (stat.tackles?.total ?? 0)
                        }
                        
                        combinedStat.goals = GoalDetailedStats(total: totalGoals, assists: totalAssists)
                        combinedStat.shots = ShotDetailedStats(total: totalShots)
                        combinedStat.passes = PassDetailedStats(total: totalPasses)
                        combinedStat.tackles = TackleDetailedStats(total: totalTackles)
                        
                        newItem.statistics = [combinedStat]
                    }
                    
                    aggregatedDict[id] = newItem
                }
            }
            
            let players = aggregatedDict.values.compactMap { Player(detailItem: $0) }
            self.filteredPlayers = players.sorted { $0.name < $1.name }
        }
    }
    
    private func translateKoreanToEnglish(_ query: String) -> [String] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        var results: [String] = []
        
        if let exactMatch = allPlayersDict[trimmed] {
            results.append(exactMatch)
        }
        
        let popularPlayers = ["주민규", "이승우", "기성용", "세징야", "설영우", "조현우", "무고사", "일류첸코", "송민규", "김영권", "이동경"]
        
        for popular in popularPlayers {
            if popular.contains(trimmed), let eng = allPlayersDict[popular] {
                if !results.contains(eng) {
                    results.append(eng)
                }
            }
        }
        
        for (koreanName, englishName) in allPlayersDict {
            if koreanName.hasPrefix(trimmed) && !results.contains(englishName) {
                results.append(englishName)
                if results.count >= 5 { return results }
            }
        }
        
        for (koreanName, englishName) in allPlayersDict {
            if koreanName.contains(trimmed) && !results.contains(englishName) {
                results.append(englishName)
                if results.count >= 5 { return results }
            }
        }
        
        if results.isEmpty {
            results.append(trimmed)
        }
        
        return results
    }
    
    private func loadAllPlayersDict() {
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
        self.leagueName = stats.league?.name
        
        self.goals = stats.goals?.total ?? 0
        self.assists = stats.goals?.assists ?? 0
        self.shots = stats.shots?.total ?? 0
        self.passes = stats.passes?.total ?? 0
        self.defense = stats.tackles?.total ?? 0
    }
}
