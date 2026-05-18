import Foundation

struct Player: Identifiable, Codable {
    let id: Int
    let name: String
    let photo: String?
    let teamName: String
    
    // 레이더 차트 비교용 데이터
    let goals: Int
    let assists: Int
    let shots: Int
    let passes: Int
    let defense: Int // 태클, 가로채기 등 수비 지표 합산 (가정)
    
    // API-Football 응답 구조에 맞춰 디코딩 로직(CodingKeys 등)이 추가되어야 합니다.
}
