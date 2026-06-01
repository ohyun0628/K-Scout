import Foundation

extension Int: Identifiable {
    public var id: Int { self }
}

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
    
    var radarData: [Double] {
        let normGoals = Double(goals) / 15.0
        let normAssists = Double(assists) / 10.0
        let normShots = Double(shots) / 60.0
        let normPasses = Double(passes) / 1000.0
        let normDefense = Double(defense) / 100.0
        
        return [
            min(1.0, max(0.05, normGoals)),
            min(1.0, max(0.05, normAssists)),
            min(1.0, max(0.05, normShots)),
            min(1.0, max(0.05, normPasses)),
            min(1.0, max(0.05, normDefense))
        ]
    }
    
    // Mock data for player search and favorites list
    static let mockPlayers: [Player] = [
        Player(id: 34427, name: "주민규", photo: nil, teamName: "울산 HD", goals: 14, assists: 3, shots: 48, passes: 320, defense: 12),
        Player(id: 34484, name: "세징야", photo: nil, teamName: "대구 FC", goals: 9, assists: 8, shots: 45, passes: 680, defense: 22),
        Player(id: 2914, name: "이승우", photo: nil, teamName: "수원 FC", goals: 11, assists: 5, shots: 38, passes: 480, defense: 15),
        Player(id: 2908, name: "나상호", photo: nil, teamName: "서울 FC", goals: 8, assists: 4, shots: 35, passes: 510, defense: 28),
        Player(id: 34547, name: "강상우", photo: nil, teamName: "서울 FC", goals: 2, assists: 7, shots: 18, passes: 820, defense: 78),
        Player(id: 34598, name: "송민규", photo: nil, teamName: "전북 현대", goals: 8, assists: 5, shots: 35, passes: 540, defense: 30),
        Player(id: 51267, name: "제르소", photo: nil, teamName: "인천 유나이티드", goals: 7, assists: 6, shots: 28, passes: 450, defense: 25),
        Player(id: 34822, name: "무고사", photo: nil, teamName: "인천 유나이티드", goals: 12, assists: 2, shots: 52, passes: 280, defense: 10),
        Player(id: 25276, name: "일류첸코", photo: nil, teamName: "서울 FC", goals: 11, assists: 4, shots: 42, passes: 310, defense: 14),
        Player(id: 34517, name: "조영욱", photo: nil, teamName: "서울 FC", goals: 6, assists: 3, shots: 24, passes: 410, defense: 35)
    ]
}
