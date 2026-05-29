
import Foundation

struct FixtureItem: Decodable {
    let fixture: FixtureInfo
    let league: LeagueInfo
    let teams: TeamMatchInfo
    let goals: GoalScoreInfo
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
struct TeamInfo: Decodable {
    let id: Int
    let name: String
    let logo: String?
}
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
        
        if let dict = try? container.decodeIfPresent([String: String].self, forKey: .errors) {
            self.errors = dict
        } else {
            self.errors = nil
        }
    }
}

do {
    let data = try Data(contentsOf: URL(fileURLWithPath: "fixtures.json"))
    let decoder = JSONDecoder()
    let response = try decoder.decode(APISportsResponse<[FixtureItem]>.self, from: data)
    print("Success! \(response.response?.count ?? 0) items decoded.")
} catch {
    print("Decoding error: \(error)")
}

