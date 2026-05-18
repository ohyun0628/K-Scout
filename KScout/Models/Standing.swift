import Foundation

struct Standing: Identifiable, Codable {
    let id: Int // Team ID
    let rank: Int
    let teamName: String
    let points: Int
    let goalsDiff: Int
    
    // API-Football 응답 구조에 맞게 추후 CodingKeys 추가 필요
}
