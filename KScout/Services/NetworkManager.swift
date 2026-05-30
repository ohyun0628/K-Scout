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
            let saved = UserDefaults.standard.string(forKey: "API_SPORTS_KEY") ?? ""
            if saved.isEmpty || saved == "YOUR_API_KEY_HERE" {
                return "4eb0b3baf194555ef46565fa9dc2d35d"
            }
            return saved
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "API_SPORTS_KEY")
        }
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        // API 키가 입력되어 있지 않은 경우 바로 실패 처리하여 폴백 유도
        guard apiKey != "YOUR_API_KEY_HERE" && !apiKey.isEmpty else {
            print("[NetworkManager] API Key is empty or placeholder. Falling back to mock data.")
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let url = endpoint.url else {
            print("[NetworkManager] Invalid URL for endpoint.")
            completion(.failure(.invalidURL))
            return
        }
        
        print("[NetworkManager] Requesting: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-apisports-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[NetworkManager] Network Error: \(error.localizedDescription)")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("[NetworkManager] Invalid HTTP response.")
                completion(.failure(.invalidResponse))
                return
            }
            
            print("[NetworkManager] Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode), let data = data else {
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
                print("[NetworkManager] Decoding Error: \(error)")
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
    
    enum CodingKeys: String, CodingKey {
        case errors
        case response
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decodeIfPresent(T.self, forKey: .response)
        
        // API-Sports는 에러가 없으면 "errors": [], 에러가 있으면 "errors": {"token": "..."}를 반환하는 불일치 존재
        if let dict = try? container.decodeIfPresent([String: String].self, forKey: .errors) {
            self.errors = dict
        } else {
            self.errors = nil
        }
    }
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
    let group: String?
    let form: String?
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
    let goals: GoalsData?
}
struct GoalsData: Decodable {
    let `for`: Int?
    let against: Int?
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
    let events: [FixtureEvent]?
    let lineups: [FixtureLineup]?
    let statistics: [FixtureStatistics]?
}
struct FixtureEvent: Decodable {
    let time: EventTime
    let team: TeamInfo
    let player: EventPlayer
    let assist: EventPlayer?
    let type: String
    let detail: String
}
struct EventTime: Decodable {
    let elapsed: Int
    let extra: Int?
}
struct EventPlayer: Decodable {
    let id: Int?
    let name: String?
}
struct FixtureLineup: Decodable {
    let team: TeamInfo
    let formation: String?
    let startXI: [LineupPlayerInfo]?
    let substitutes: [LineupPlayerInfo]?
}
struct LineupPlayerInfo: Decodable {
    let player: LineupPlayer
}
struct LineupPlayer: Decodable {
    let id: Int?
    let name: String
    let number: Int?
    let pos: String?
}
struct FixtureStatistics: Decodable {
    let team: TeamInfo
    let statistics: [StatDetail]
}
struct StatDetail: Decodable {
    let type: String
    let value: StatValue?
}
enum StatValue: Decodable {
    case int(Int)
    case string(String)
    case none
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let strVal = try? container.decode(String.self) {
            self = .string(strVal)
        } else {
            self = .none
        }
    }
}
struct FixtureInfo: Decodable {
    let id: Int
    let date: String
    let venue: VenueInfo?
    let status: StatusInfo
}
struct VenueInfo: Decodable {
    let name: String?
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
