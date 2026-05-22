import Foundation

struct Standing: Identifiable, Codable {
    let id: Int // Team ID
    let rank: Int
    let teamName: String
    let points: Int
    let goalsDiff: Int
    let played: Int
    let won: Int
    let draw: Int
    let lost: Int
    let league: Int // 1: K리그1, 2: K리그2
    let group: String? // "Championship Round" or "Relegation Round"
    let form: String? // e.g. "WWDLW"
}
