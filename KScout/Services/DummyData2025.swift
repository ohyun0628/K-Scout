import Foundation

struct DummyData2025 {
    // MARK: - 2025 시즌 팀 순위 (Standings)
    static var standings: [Standing] {
        let league1 = [
            Standing(id: 101, rank: 1, teamName: "전북 현대", points: 75, goalsDiff: 28, played: 38, won: 22, draw: 9, lost: 7, league: 1),
            Standing(id: 102, rank: 2, teamName: "김천 상무", points: 68, goalsDiff: 19, played: 38, won: 19, draw: 11, lost: 8, league: 1),
            Standing(id: 103, rank: 3, teamName: "대전 하나", points: 65, goalsDiff: 15, played: 38, won: 18, draw: 11, lost: 9, league: 1),
            Standing(id: 104, rank: 4, teamName: "포항 스틸러스", points: 62, goalsDiff: 12, played: 38, won: 17, draw: 11, lost: 10, league: 1),
            Standing(id: 105, rank: 5, teamName: "FC 서울", points: 59, goalsDiff: 8, played: 38, won: 16, draw: 11, lost: 11, league: 1),
            Standing(id: 106, rank: 6, teamName: "강원 FC", points: 55, goalsDiff: 3, played: 38, won: 15, draw: 10, lost: 13, league: 1),
            Standing(id: 107, rank: 7, teamName: "FC 안양", points: 51, goalsDiff: -4, played: 38, won: 14, draw: 9, lost: 15, league: 1),
            Standing(id: 108, rank: 8, teamName: "광주 FC", points: 48, goalsDiff: -6, played: 38, won: 13, draw: 9, lost: 16, league: 1),
            Standing(id: 109, rank: 9, teamName: "울산 HD FC", points: 46, goalsDiff: -8, played: 38, won: 12, draw: 10, lost: 16, league: 1),
            Standing(id: 110, rank: 10, teamName: "수원 FC", points: 42, goalsDiff: -12, played: 38, won: 11, draw: 9, lost: 18, league: 1),
            Standing(id: 111, rank: 11, teamName: "제주 유나이티드", points: 38, goalsDiff: -15, played: 38, won: 9, draw: 11, lost: 18, league: 1),
            Standing(id: 112, rank: 12, teamName: "대구 FC", points: 35, goalsDiff: -20, played: 38, won: 8, draw: 11, lost: 19, league: 1)
        ]
        
        let league2 = [
            Standing(id: 201, rank: 1, teamName: "인천 유나이티드", points: 69, goalsDiff: 18, played: 36, won: 20, draw: 9, lost: 7, league: 2),
            Standing(id: 202, rank: 2, teamName: "부천 FC 1995", points: 64, goalsDiff: 13, played: 36, won: 18, draw: 10, lost: 8, league: 2),
            Standing(id: 203, rank: 3, teamName: "수원 삼성", points: 61, goalsDiff: 10, played: 36, won: 17, draw: 10, lost: 9, league: 2),
            Standing(id: 204, rank: 4, teamName: "서울 이랜드", points: 58, goalsDiff: 7, played: 36, won: 16, draw: 10, lost: 10, league: 2),
            Standing(id: 205, rank: 5, teamName: "전남 드래곤즈", points: 53, goalsDiff: 2, played: 36, won: 14, draw: 11, lost: 11, league: 2),
            Standing(id: 206, rank: 6, teamName: "부산 아이파크", points: 50, goalsDiff: -1, played: 36, won: 13, draw: 11, lost: 12, league: 2),
            Standing(id: 207, rank: 7, teamName: "성남 FC", points: 45, goalsDiff: -5, played: 36, won: 11, draw: 12, lost: 13, league: 2),
            Standing(id: 208, rank: 8, teamName: "충남아산 FC", points: 42, goalsDiff: -8, played: 36, won: 10, draw: 12, lost: 14, league: 2)
        ]
        
        return league1 + league2
    }
    
    // MARK: - 2025 시즌 선수 순위 (Player Rankings)
    static var playerRankings: [PlayerRanking] {
        let goalsL1 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "사바그", teamName: "전북 현대", statCount: 17, played: 34, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "이동경", teamName: "김천 상무", statCount: 14, played: 33, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "일류첸코", teamName: "서울 FC", statCount: 13, played: 35, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "주민규", teamName: "울산 HD", statCount: 12, played: 32, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "무고사", teamName: "인천 유나이티드", statCount: 11, played: 36, league: 1, type: "goals")
        ]
        
        let assistsL1 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "세징야", teamName: "대구 FC", statCount: 9, played: 35, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "이동경", teamName: "김천 상무", statCount: 8, played: 33, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "송민규", teamName: "전북 현대", statCount: 7, played: 34, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "안데르손", teamName: "수원 FC", statCount: 7, played: 35, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "기성용", teamName: "서울 FC", statCount: 6, played: 32, league: 1, type: "assists")
        ]
        
        let goalsL2 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "제르소", teamName: "인천 유나이티드", statCount: 15, played: 32, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "루페타", teamName: "부천 FC 1995", statCount: 13, played: 33, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "뮬리치", teamName: "수원 삼성", statCount: 11, played: 30, league: 2, type: "goals")
        ]
        
        let assistsL2 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 10, played: 34, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "홍창범", teamName: "부천 FC 1995", statCount: 7, played: 33, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "아코스티", teamName: "수원 삼성", statCount: 6, played: 28, league: 2, type: "assists")
        ]
        
        return goalsL1 + assistsL1 + goalsL2 + assistsL2
    }
    
    // MARK: - 2025 시즌 경기 일정 (Match Schedules)
    static var matches: [MockMatch] {
        let league1 = [
            MockMatch(homeTeam: "전북 현대 모터스", awayTeam: "김천 상무", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "전주월드컵경기장", league: 1, dayOffset: 0),
            MockMatch(homeTeam: "대전 하나 시티즌", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "대전월드컵경기장", league: 1, dayOffset: 0),
            MockMatch(homeTeam: "FC 서울", awayTeam: "강원 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "서울월드컵경기장", league: 1, dayOffset: 0),
            
            MockMatch(homeTeam: "FC 안양", awayTeam: "광주 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "안양종합운동장", league: 1, dayOffset: 1),
            MockMatch(homeTeam: "울산 HD FC", awayTeam: "수원 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "울산문수축구경기장", league: 1, dayOffset: 1),
            
            MockMatch(homeTeam: "제주 유나이티드", awayTeam: "대구 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "제주월드컵경기장", league: 1, dayOffset: -1)
        ]
        
        let league2 = [
            MockMatch(homeTeam: "인천 유나이티드", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "인천축구전용경기장", league: 2, dayOffset: 0),
            MockMatch(homeTeam: "수원 삼성", awayTeam: "서울 이랜드", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원월드컵경기장", league: 2, dayOffset: 0),
            MockMatch(homeTeam: "전남 드래곤즈", awayTeam: "부산 아이파크", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "광양축구전용구장", league: 2, dayOffset: 0),
            
            MockMatch(homeTeam: "성남 FC", awayTeam: "충남아산 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "탄천종합운동장", league: 2, dayOffset: 1),
            MockMatch(homeTeam: "천안 시티 FC", awayTeam: "김포 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안종합운동장", league: 2, dayOffset: -1)
        ]
        
        return league1 + league2
    }
}
