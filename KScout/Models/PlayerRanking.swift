import Foundation

struct PlayerRanking: Identifiable, Codable {
    let id: UUID
    let rank: Int
    let playerName: String
    let teamName: String
    let statCount: Int // Goals or Assists count
    let played: Int // Matches played
    let league: Int // 1: K리그1, 2: K리그2
    let type: String // "goals" or "assists"
}
