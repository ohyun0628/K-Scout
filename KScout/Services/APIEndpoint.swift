import Foundation

enum APIEndpoint {
    case standings(league: Int, season: Int)
    case fixtures(league: Int, season: Int)
    case players(team: Int, season: Int)
    case topScorers(league: Int, season: Int)
    case topAssists(league: Int, season: Int)
    
    var baseURL: String {
        return "https://v3.football.api-sports.io"
    }
    
    var path: String {
        switch self {
        case .standings: return "/standings"
        case .fixtures: return "/fixtures"
        case .players: return "/players"
        case .topScorers: return "/players/topscorers"
        case .topAssists: return "/players/topassists"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .standings(let league, let season),
             .fixtures(let league, let season),
             .topScorers(let league, let season),
             .topAssists(let league, let season):
            return [
                URLQueryItem(name: "league", value: String(league)),
                URLQueryItem(name: "season", value: String(season))
            ]
        case .players(let team, let season):
            return [
                URLQueryItem(name: "team", value: String(team)),
                URLQueryItem(name: "season", value: String(season))
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
