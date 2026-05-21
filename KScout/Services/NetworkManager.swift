import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case apiError(String)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // API-Football 발급 키 (기본값 설정, 필요시 유저가 변경 가능)
    var apiKey: String {
        get {
            UserDefaults.standard.string(forKey: "API_SPORTS_KEY") ?? "YOUR_API_KEY_HERE"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "API_SPORTS_KEY")
        }
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        // API 키가 입력되어 있지 않은 경우 바로 실패 처리하여 폴백 유도
        guard apiKey != "YOUR_API_KEY_HERE" && !apiKey.isEmpty else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-apisports-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // API-Sports의 에러 응답 및 실제 데이터 구조 유효성 검사
                let apiResponse = try decoder.decode(APISportsResponse<T>.self, from: data)
                
                if let apiErrors = apiResponse.errors, !apiErrors.isEmpty {
                    let errorMessage = apiErrors.values.joined(separator: ", ")
                    completion(.failure(.apiError(errorMessage)))
                    return
                }
                
                if let responseData = apiResponse.response {
                    DispatchQueue.main.async {
                        completion(.success(responseData))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

// MARK: - API Response DTO Models

struct APISportsResponse<T: Decodable>: Decodable {
    let errors: [String: String]?
    let response: T?
}

// 1. 팀 순위 (Standings) DTO
struct StandingsResponse: Decodable {
    let league: LeagueStandingData
}
struct LeagueStandingData: Decodable {
    let id: Int
    let name: String
    let standings: [[TeamStandingData]]
}
struct TeamStandingData: Decodable {
    let rank: Int
    let team: TeamInfo
    let points: Int
    let goalsDiff: Int
    let all: StandingStatDetail
}
struct TeamInfo: Decodable {
    let id: Int
    let name: String
    let logo: String?
}
struct StandingStatDetail: Decodable {
    let played: Int
    let win: Int
    let draw: Int
    let lose: Int
}

// 2. 선수 랭킹 (Top Scorers & Top Assists) DTO
struct PlayerRankingItem: Decodable {
    let player: PlayerProfile
    let statistics: [PlayerStatsItem]
}
struct PlayerProfile: Decodable {
    let id: Int
    let name: String
    let photo: String?
}
struct PlayerStatsItem: Decodable {
    let team: TeamInfo
    let games: GameStats
    let goals: GoalStats
    let assists: AssistStats?
}
struct GameStats: Decodable {
    let appearances: Int?
}
struct GoalStats: Decodable {
    let total: Int?
}
struct AssistStats: Decodable {
    let total: Int?
}

// 3. 경기 일정 (Fixtures) DTO
struct FixtureItem: Decodable {
    let fixture: FixtureInfo
    let league: LeagueInfo
    let teams: TeamMatchInfo
    let goals: GoalScoreInfo
}
struct FixtureInfo: Decodable {
    let id: Int
    let date: String
    let status: StatusInfo
}
struct StatusInfo: Decodable {
    let long: String
    let short: String
    let elapsed: Int?
}
struct LeagueInfo: Decodable {
    let id: Int
    let name: String
    let season: Int
}
struct TeamMatchInfo: Decodable {
    let home: TeamInfo
    let away: TeamInfo
}
struct GoalScoreInfo: Decodable {
    let home: Int?
    let away: Int?
}

// 4. 선수 상세 분석 및 검색 (Players) DTO
struct PlayerDetailItem: Decodable {
    let player: PlayerProfileInfo
    let statistics: [PlayerDetailedStats]
}
struct PlayerProfileInfo: Decodable {
    let id: Int
    let name: String
    let photo: String?
}
struct PlayerDetailedStats: Decodable {
    let team: TeamInfo
    let games: GameDetailedStats?
    let shots: ShotDetailedStats?
    let goals: GoalDetailedStats?
    let passes: PassDetailedStats?
    let tackles: TackleDetailedStats?
}
struct GameDetailedStats: Decodable {
    let position: String?
}
struct ShotDetailedStats: Codable {
    let total: Int?
}
struct GoalDetailedStats: Codable {
    let total: Int?
    let assists: Int?
}
struct PassDetailedStats: Codable {
    let total: Int?
}
struct TackleDetailedStats: Codable {
    let total: Int?
}
