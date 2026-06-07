import Foundation
import Combine

class PlayerSummaryViewModel: ObservableObject {
    @Published var playerDetail: PlayerDetailItem?
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    func fetchPlayer(id: Int, season: Int) {
        isLoading = true
        errorMessage = nil
        
        let seasons = [2022, 2023, 2024]
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.kscout.playerDetail")
        var allFetchedItems: [PlayerDetailItem] = []
        var finalError: Error?
        
        if MockPlayerService.shared.useMockData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let mockItems = MockPlayerService.shared.getMockPlayerDetail()
                allFetchedItems.append(contentsOf: mockItems)
                self.processFetchedItems(allFetchedItems)
            }
            return
        }
        
        for s in seasons {
            group.enter()
            NetworkManager.shared.request(endpoint: .playerDetail(id: id, season: s)) { (result: Result<[PlayerDetailItem], NetworkError>) in
                switch result {
                case .success(let items):
                    if let item = items.first {
                        queue.async {
                            allFetchedItems.append(item)
                        }
                    }
                case .failure(let error):
                    finalError = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.processFetchedItems(allFetchedItems)
        }
    }
    
    private func processFetchedItems(_ allFetchedItems: [PlayerDetailItem]) {
        self.isLoading = false
            
            if allFetchedItems.isEmpty {
                self.errorMessage = finalError?.localizedDescription ?? "선수 정보를 찾을 수 없습니다."
            } else {
                // K리그 스탯만 필터링 (292: K리그1, 293: K리그2)
                var kLeagueStats: [PlayerDetailedStats] = []
                for item in allFetchedItems {
                    let filtered = item.statistics.filter { $0.league?.id == 292 || $0.league?.id == 293 }
                    kLeagueStats.append(contentsOf: filtered)
                }
                
                if var baseStat = kLeagueStats.last ?? allFetchedItems.first?.statistics.first {
                    var totalGoals = 0
                    var totalAssists = 0
                    var totalShots = 0
                    var totalPasses = 0
                    var totalTackles = 0
                    var totalApps = 0
                    
                    for stat in kLeagueStats {
                        totalGoals += (stat.goals?.total ?? 0)
                        totalAssists += (stat.goals?.assists ?? 0)
                        totalShots += (stat.shots?.total ?? 0)
                        totalPasses += (stat.passes?.total ?? 0)
                        totalTackles += (stat.tackles?.total ?? 0)
                        totalApps += (stat.games?.appearences ?? 0)
                    }
                    
                    baseStat.goals = GoalDetailedStats(total: totalGoals, assists: totalAssists)
                    baseStat.shots = ShotDetailedStats(total: totalShots)
                    baseStat.passes = PassDetailedStats(total: totalPasses)
                    baseStat.tackles = TackleDetailedStats(total: totalTackles)
                    
                    if var games = baseStat.games {
                        games.appearences = totalApps
                        baseStat.games = games
                    } else {
                        baseStat.games = GameDetailedStats(appearences: totalApps, lineups: nil, minutes: nil, number: nil, position: nil, rating: nil, captain: nil)
                    }
                    
                    // 시즌별 소속 리그 문자열 생성 (예: "K1('22), K2('23)")
                    var seasonLeagueMap: [Int: String] = [:]
                    for stat in kLeagueStats {
                        if let s = stat.league?.season, let id = stat.league?.id {
                            let leagueStr = (id == 292) ? "K1" : "K2"
                            seasonLeagueMap[s] = leagueStr
                        }
                    }
                    
                    let sortedSeasons = seasonLeagueMap.keys.sorted()
                    var nameParts: [String] = []
                    
                    // 만약 22, 23, 24 모두 같은 리그라면 하나로 통일
                    let uniqueLeagues = Set(seasonLeagueMap.values)
                    if uniqueLeagues.count == 1, let singleLeague = uniqueLeagues.first {
                        let leagueKr = (singleLeague == "K1") ? "K리그1" : "K리그2"
                        if sortedSeasons == [2022, 2023, 2024] {
                            nameParts.append("\(leagueKr) 22~24")
                        } else if !sortedSeasons.isEmpty {
                            let seasonStrs = sortedSeasons.map { String($0).suffix(2) }.joined(separator: ", ")
                            nameParts.append("\(leagueKr) (\(seasonStrs))")
                        } else {
                            nameParts.append(leagueKr)
                        }
                    } else if !sortedSeasons.isEmpty {
                        for s in sortedSeasons {
                            let leagueStr = seasonLeagueMap[s]!
                            let shortSeason = String(s).suffix(2)
                            nameParts.append("\(leagueStr)('\(shortSeason))")
                        }
                    } else {
                        nameParts.append("K리그")
                    }
                    
                    let combinedLeagueName = nameParts.joined(separator: ", ")
                    baseStat.league = LeagueInfo(id: 292, name: combinedLeagueName, season: 2024)
                    
                    var baseItem = allFetchedItems.last ?? allFetchedItems.first!
                    baseItem.statistics = [baseStat]
                    self.playerDetail = baseItem
                } else {
                    self.playerDetail = allFetchedItems.first
                }
            }
    }
}
