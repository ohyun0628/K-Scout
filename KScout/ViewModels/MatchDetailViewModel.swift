import Foundation

class MatchDetailViewModel: ObservableObject {
    @Published var fixtureDetails: FixtureItem? = nil
    @Published var homeStanding: TeamStandingData? = nil
    @Published var awayStanding: TeamStandingData? = nil
    @Published var homeTopPlayers: [PlayerRankingItem] = []
    @Published var awayTopPlayers: [PlayerRankingItem] = []
    
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
        
        let dispatchGroup = DispatchGroup()
        let season = 2024
        let leagueId = match.league
        
        // 1. Fixture Detail
        dispatchGroup.enter()
        NetworkManager.shared.request(endpoint: .fixtureDetail(id: apiId)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.fixtureDetails = items.first
                case .failure: break
                }
                dispatchGroup.leave()
            }
        }
        
        // 2. Standings
        dispatchGroup.enter()
        NetworkManager.shared.request(endpoint: .standings(league: leagueId, season: season)) { (result: Result<[StandingsResponse], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    if let standings = items.first?.league.standings.first {
                        let hTeamName = self.match.homeTeam.replacingOccurrences(of: " ", with: "")
                        let aTeamName = self.match.awayTeam.replacingOccurrences(of: " ", with: "")
                        
                        self.homeStanding = standings.first { 
                            let apiName = KoreanTranslationService.translateTeam($0.team.name).replacingOccurrences(of: " ", with: "")
                            return apiName.contains(hTeamName) || hTeamName.contains(apiName) || $0.team.name == self.match.homeTeam
                        }
                        
                        self.awayStanding = standings.first { 
                            let apiName = KoreanTranslationService.translateTeam($0.team.name).replacingOccurrences(of: " ", with: "")
                            return apiName.contains(aTeamName) || aTeamName.contains(apiName) || $0.team.name == self.match.awayTeam
                        }
                    }
                case .failure: break
                }
                dispatchGroup.leave()
            }
        }
        
        // 3. Top Scorers
        dispatchGroup.enter()
        NetworkManager.shared.request(endpoint: .topScorers(league: leagueId, season: season)) { (result: Result<[PlayerRankingItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    let hTeamName = self.match.homeTeam.replacingOccurrences(of: " ", with: "")
                    let aTeamName = self.match.awayTeam.replacingOccurrences(of: " ", with: "")
                    
                    self.homeTopPlayers = items.filter { item in
                        guard let tName = item.statistics.first?.team.name else { return false }
                        let apiName = KoreanTranslationService.translateTeam(tName).replacingOccurrences(of: " ", with: "")
                        return apiName.contains(hTeamName) || hTeamName.contains(apiName) || tName == self.match.homeTeam
                    }
                    self.awayTopPlayers = items.filter { item in
                        guard let tName = item.statistics.first?.team.name else { return false }
                        let apiName = KoreanTranslationService.translateTeam(tName).replacingOccurrences(of: " ", with: "")
                        return apiName.contains(aTeamName) || aTeamName.contains(apiName) || tName == self.match.awayTeam
                    }
                case .failure: break
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            if self.fixtureDetails == nil {
                self.generateMockDetails()
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
        
        let homeStartXI = [
            LineupPlayerInfo(player: LineupPlayer(id: 1, name: "Jo Hyeon-Woo", number: 21, pos: "G")),
            LineupPlayerInfo(player: LineupPlayer(id: 2, name: "Seol Young-Woo", number: 66, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 3, name: "Kim Young-Gwon", number: 19, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 4, name: "Jung Seung-Hyun", number: 15, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 5, name: "Lee Myung-Jae", number: 13, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 6, name: "Um Won-Sang", number: 11, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 7, name: "Lee Kyu-Seong", number: 24, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 8, name: "Ko Seung-Beom", number: 8, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 9, name: "Lee Chung-Yong", number: 27, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 10, name: "Joo Min-Kyu", number: 18, pos: "F")),
            LineupPlayerInfo(player: LineupPlayer(id: 11, name: "Gustav Ludwigson", number: 17, pos: "F"))
        ]
        
        let awayStartXI = [
            LineupPlayerInfo(player: LineupPlayer(id: 12, name: "Song Bum-Keun", number: 1, pos: "G")),
            LineupPlayerInfo(player: LineupPlayer(id: 13, name: "Kim Jin-Su", number: 23, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 14, name: "Hong Jeong-Ho", number: 26, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 15, name: "Park Jin-Seop", number: 4, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 16, name: "Ahn Hyeon-Beom", number: 94, pos: "D")),
            LineupPlayerInfo(player: LineupPlayer(id: 17, name: "Moon Seon-Min", number: 27, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 18, name: "Paik Seung-Ho", number: 8, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 19, name: "Song Min-Kyu", number: 17, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 20, name: "Lee Yeong-Jae", number: 13, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 21, name: "Tiago Orobó", number: 9, pos: "F")),
            LineupPlayerInfo(player: LineupPlayer(id: 22, name: "Hernandes", number: 10, pos: "F"))
        ]
        
        let homeSubs = [
            LineupPlayerInfo(player: LineupPlayer(id: 23, name: "Jo Su-Huk", number: 1, pos: "G")),
            LineupPlayerInfo(player: LineupPlayer(id: 24, name: "Ataru", number: 33, pos: "M")),
            LineupPlayerInfo(player: LineupPlayer(id: 25, name: "Kim Min-Woo", number: 10, pos: "M"))
        ]
        
        let awaySubs = [
            LineupPlayerInfo(player: LineupPlayer(id: 26, name: "Kim Jeong-Hoon", number: 13, pos: "G")),
            LineupPlayerInfo(player: LineupPlayer(id: 27, name: "Han Kyo-Won", number: 7, pos: "F")),
            LineupPlayerInfo(player: LineupPlayer(id: 28, name: "Jeon Byung-Kwan", number: 11, pos: "M"))
        ]
        
        let lineups = [
            FixtureLineup(team: homeTeam, formation: "4-4-2", startXI: homeStartXI, substitutes: homeSubs),
            FixtureLineup(team: awayTeam, formation: "4-2-3-1", startXI: awayStartXI, substitutes: awaySubs)
        ]
        
        let mockEvents = [
            FixtureEvent(time: EventTime(elapsed: 15, extra: nil), team: homeTeam, player: EventPlayer(id: 10, name: "Joo Min-Kyu"), assist: EventPlayer(id: 6, name: "Um Won-Sang"), type: "Goal", detail: "Normal Goal"),
            FixtureEvent(time: EventTime(elapsed: 32, extra: nil), team: awayTeam, player: EventPlayer(id: 13, name: "Kim Jin-Su"), assist: nil, type: "Card", detail: "Yellow Card"),
            FixtureEvent(time: EventTime(elapsed: 45, extra: 2), team: awayTeam, player: EventPlayer(id: 21, name: "Tiago Orobó"), assist: EventPlayer(id: 19, name: "Song Min-Kyu"), type: "Goal", detail: "Header"),
            FixtureEvent(time: EventTime(elapsed: 60, extra: nil), team: homeTeam, player: EventPlayer(id: 24, name: "Ataru"), assist: EventPlayer(id: 7, name: "Lee Kyu-Seong"), type: "subst", detail: "Substitution 1"),
            FixtureEvent(time: EventTime(elapsed: 88, extra: nil), team: homeTeam, player: EventPlayer(id: 11, name: "Gustav Ludwigson"), assist: EventPlayer(id: 2, name: "Seol Young-Woo"), type: "Goal", detail: "Normal Goal")
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
            events: mockEvents,
            lineups: lineups,
            statistics: statistics
        )
        
        self.fixtureDetails = mockItem
    }
}
