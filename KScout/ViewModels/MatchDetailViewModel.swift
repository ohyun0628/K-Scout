import Foundation

class MatchDetailViewModel: ObservableObject {
    @Published var fixtureDetails: FixtureItem? = nil
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let match: MockMatch
    
    init(match: MockMatch) {
        self.match = match
    }
    
    func fetchMatchDetails() {
        guard let apiId = match.apiId else {
            // Fallback to mock data if it's a mock match
            generateMockDetails()
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        NetworkManager.shared.request(endpoint: .fixtureDetail(id: apiId)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let items):
                    if let first = items.first {
                        self.fixtureDetails = first
                    } else {
                        self.generateMockDetails()
                    }
                case .failure:
                    self.generateMockDetails()
                }
            }
        }
    }
    
    private func generateMockDetails() {
        // Mock data generator for MatchDetails when API is exhausted or not provided
        let homeTeam = TeamInfo(id: 1, name: match.homeTeam, logo: nil)
        let awayTeam = TeamInfo(id: 2, name: match.awayTeam, logo: nil)
        
        let stats: [StatDetail] = [
            StatDetail(type: "Ball Possession", value: .string("55%")),
            StatDetail(type: "Total Shots", value: .int(12)),
            StatDetail(type: "Shots on Goal", value: .int(5)),
            StatDetail(type: "Fouls", value: .int(10)),
            StatDetail(type: "Corner Kicks", value: .int(4)),
            StatDetail(type: "Yellow Cards", value: .int(2)),
            StatDetail(type: "Passes %", value: .string("85%"))
        ]
        
        let awayStats: [StatDetail] = [
            StatDetail(type: "Ball Possession", value: .string("45%")),
            StatDetail(type: "Total Shots", value: .int(8)),
            StatDetail(type: "Shots on Goal", value: .int(3)),
            StatDetail(type: "Fouls", value: .int(12)),
            StatDetail(type: "Corner Kicks", value: .int(2)),
            StatDetail(type: "Yellow Cards", value: .int(3)),
            StatDetail(type: "Passes %", value: .string("78%"))
        ]
        
        let lineups = [
            FixtureLineup(team: homeTeam, formation: "4-3-3", startXI: [], substitutes: []),
            FixtureLineup(team: awayTeam, formation: "4-4-2", startXI: [], substitutes: [])
        ]
        
        let statistics = [
            FixtureStatistics(team: homeTeam, statistics: stats),
            FixtureStatistics(team: awayTeam, statistics: awayStats)
        ]
        
        let mockItem = FixtureItem(
            fixture: FixtureInfo(id: match.apiId ?? 0, date: "", venue: VenueInfo(name: match.stadium), status: StatusInfo(long: "Finished", short: match.status, elapsed: 90)),
            league: LeagueInfo(id: match.league, name: "K League", season: 2024),
            teams: TeamMatchInfo(home: homeTeam, away: awayTeam),
            goals: GoalScoreInfo(home: match.homeScore, away: match.awayScore),
            events: [],
            lineups: lineups,
            statistics: statistics
        )
        
        self.fixtureDetails = mockItem
    }
}
