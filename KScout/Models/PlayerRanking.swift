import Foundation

struct PlayerRanking: Identifiable, Codable {
    let id: UUID
    let rank: Int
    let playerName: String
    let teamName: String
    let statCount: Int // 메인 스탯 값 (예: 15골, 10도움 등)
    let played: Int
    let league: Int
    let type: String
    let photoURL: String?
    
    // K-Scout 가독성 및 정밀 분석을 위한 지표 추가
    var goals: Int
    var assists: Int
    var attackPoints: Int
    var momCount: Int
    var avgRating: Double
    var best11Count: Int
    var goalsPer90: Double
    var pointsPer90: Double
    
    // 유저 제안 추가 지표: 슈팅, 유효슈팅, 출전시간(분)
    var shots: Int
    var shotsOnTarget: Int
    var playedMinutes: Int
    
    // 네이버 스포츠 대시보드 추가 대응: PK골, 파울, 경고
    var pkGoals: Int
    var fouls: Int
    var yellowCards: Int
    
    init(
        id: UUID = UUID(),
        rank: Int,
        playerName: String,
        teamName: String,
        statCount: Int,
        played: Int,
        league: Int,
        type: String,
        photoURL: String? = nil,
        goals: Int? = nil,
        assists: Int? = nil,
        attackPoints: Int? = nil,
        momCount: Int? = nil,
        avgRating: Double? = nil,
        best11Count: Int? = nil,
        goalsPer90: Double? = nil,
        pointsPer90: Double? = nil,
        shots: Int? = nil,
        shotsOnTarget: Int? = nil,
        playedMinutes: Int? = nil,
        pkGoals: Int? = nil,
        fouls: Int? = nil,
        yellowCards: Int? = nil
    ) {
        self.id = id
        self.rank = rank
        self.playerName = playerName
        self.teamName = teamName
        self.statCount = statCount
        self.played = played
        self.league = league
        self.type = type
        self.photoURL = photoURL
        
        // 기본값 세팅 및 득점/도움 기반 공격포인트 연산
        let g = goals ?? (type == "goals" ? statCount : Int.random(in: 1...5))
        let a = assists ?? (type == "assists" ? statCount : Int.random(in: 0...4))
        self.goals = g
        self.assists = a
        self.attackPoints = attackPoints ?? (g + a)
        
        self.momCount = momCount ?? Int.random(in: 1...6)
        
        // 7.0 내외의 현실성 높은 평점 디폴트
        self.avgRating = avgRating ?? (Double(Int.random(in: 68...79)) / 10.0)
        self.best11Count = best11Count ?? Int.random(in: 1...8)
        
        // 90분 경기 기준 분 환산율 (평균 출장 85분 기준)
        let mins = playedMinutes ?? (played * 85)
        self.playedMinutes = mins
        let playedMins = Double(mins)
        
        let gp90 = goalsPer90 ?? (playedMins > 0 ? (Double(g) / (playedMins / 90.0)) : 0.0)
        let pp90 = pointsPer90 ?? (playedMins > 0 ? (Double(g + a) / (playedMins / 90.0)) : 0.0)
        
        // 소수점 둘째 자리까지 반올림 정렬
        self.goalsPer90 = (gp90 * 100).rounded() / 100
        self.pointsPer90 = (pp90 * 100).rounded() / 100
        
        // 슈팅 및 유효슈팅 생성
        let s = shots ?? (g * 3 + Int.random(in: 10...30))
        self.shots = s
        self.shotsOnTarget = shotsOnTarget ?? (g + Int.random(in: 5...15))
        
        // PK골, 파울, 경고 생성
        self.pkGoals = pkGoals ?? Int.random(in: 0...3)
        self.fouls = fouls ?? Int.random(in: 10...40)
        self.yellowCards = yellowCards ?? Int.random(in: 0...6)
    }
}
