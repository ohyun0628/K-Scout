import Foundation

enum APIEndpoint {
    case standings(league: Int, season: Int)
    case fixtures(league: Int, season: Int, team: Int? = nil)
    case players(team: Int, season: Int)
    case playerSearch(query: String, league: Int, season: Int)
    case topScorers(league: Int, season: Int)
    case topAssists(league: Int, season: Int)
    
    var baseURL: String {
        return "https://v3.football.api-sports.io"
    }
    
    var path: String {
        switch self {
        case .standings: return "/standings"
        case .fixtures: return "/fixtures"
        case .players, .playerSearch: return "/players"
        case .topScorers: return "/players/topscorers"
        case .topAssists: return "/players/topassists"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .standings(let league, let season),
             .topScorers(let league, let season),
             .topAssists(let league, let season):
            let apiLeague = (league == 1) ? 292 : 293
            return [
                URLQueryItem(name: "league", value: String(apiLeague)),
                URLQueryItem(name: "season", value: String(season))
            ]
        case .fixtures(let league, let season, let team):
            let apiLeague = (league == 1) ? 292 : 293
            var items = [
                URLQueryItem(name: "league", value: String(apiLeague)),
                URLQueryItem(name: "season", value: String(season))
            ]
            if let teamId = team {
                items.append(URLQueryItem(name: "team", value: String(teamId)))
            }
            return items
        case .players(let team, let season):
            return [
                URLQueryItem(name: "team", value: String(team)),
                URLQueryItem(name: "season", value: String(season))
            ]
        case .playerSearch(let query, let league, let season):
            let apiLeague = (league == 1) ? 292 : 293
            return [
                URLQueryItem(name: "search", value: query),
                URLQueryItem(name: "league", value: String(apiLeague)),
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
