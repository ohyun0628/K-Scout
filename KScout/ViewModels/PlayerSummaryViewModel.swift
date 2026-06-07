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
            self.isLoading = false
            
            if allFetchedItems.isEmpty {
                self.errorMessage = finalError?.localizedDescription ?? "선수 정보를 찾을 수 없습니다."
            } else {
                // 스탯 통합 로직
                // 24년 또는 존재하는 가장 최근 데이터를 베이스로 잡음
                var baseItem = allFetchedItems.last ?? allFetchedItems.first!
                
                if var baseStat = baseItem.statistics.first {
                    var totalGoals = 0
                    var totalAssists = 0
                    var totalShots = 0
                    var totalPasses = 0
                    var totalTackles = 0
                    var totalApps = 0
                    
                    for item in allFetchedItems {
                        if let stat = item.statistics.first {
                            totalGoals += (stat.goals?.total ?? 0)
                            totalAssists += (stat.goals?.assists ?? 0)
                            totalShots += (stat.shots?.total ?? 0)
                            totalPasses += (stat.passes?.total ?? 0)
                            totalTackles += (stat.tackles?.total ?? 0)
                            totalApps += (stat.games?.appearences ?? 0)
                        }
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
                    
                    baseItem.statistics[0] = baseStat
                }
                
                self.playerDetail = baseItem
            }
        }
    }
}
