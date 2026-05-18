import Foundation

struct Match: Identifiable, Codable {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int?
    let awayScore: Int?
    let status: String // "NS" (Not Started), "LIVE", "FT" (Full Time) 등
    let date: Date
    
    // API-Football 응답 구조에 맞게 커스텀 디코딩 필요
}
