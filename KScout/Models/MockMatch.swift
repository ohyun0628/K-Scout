import Foundation

struct MockMatch: Identifiable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int?
    let awayScore: Int?
    let status: String // "LIVE", "NS" (Not Started), "FT" (Finished)
    let time: String // e.g. "15:00" or "67'"
    let stadium: String
    let league: Int // 1 for K리그1, 2 for K리그2
    let dayOffset: Int // Offset from selected date (e.g. 0 for "목 18", -3 for "월 15")
}
