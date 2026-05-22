import Foundation

struct DummyData2025 {
    // MARK: - 2025 시즌 팀 순위 (Standings)
    static var standings: [Standing] {
        let league1 = [
            Standing(id: 101, rank: 1, teamName: "울산 HD", points: 72, goalsDiff: 22, played: 38, won: 21, draw: 9, lost: 8, league: 1, group: "Championship Round", form: "WWDLW"),
            Standing(id: 102, rank: 2, teamName: "강원 FC", points: 64, goalsDiff: 6, played: 38, won: 19, draw: 7, lost: 12, league: 1, group: "Championship Round", form: "WWDLW"),
            Standing(id: 103, rank: 3, teamName: "김천 상무", points: 63, goalsDiff: 14, played: 38, won: 18, draw: 9, lost: 11, league: 1, group: "Championship Round", form: "WDWWL"),
            Standing(id: 104, rank: 4, teamName: "FC 서울", points: 58, goalsDiff: 13, played: 38, won: 16, draw: 10, lost: 12, league: 1, group: "Championship Round", form: "WLDLD"),
            Standing(id: 105, rank: 5, teamName: "수원 FC", points: 53, goalsDiff: -3, played: 38, won: 15, draw: 8, lost: 15, league: 1, group: "Championship Round", form: "WWLDW"),
            Standing(id: 106, rank: 6, teamName: "포항 스틸러스", points: 53, goalsDiff: 3, played: 38, won: 14, draw: 11, lost: 13, league: 1, group: "Championship Round", form: "WDDDL"),
            Standing(id: 107, rank: 7, teamName: "제주 유나이티드", points: 49, goalsDiff: -16, played: 38, won: 15, draw: 4, lost: 19, league: 1, group: "Relegation Round", form: "WLWLL"),
            Standing(id: 108, rank: 8, teamName: "대전 하나 시티즌", points: 48, goalsDiff: -4, played: 38, won: 12, draw: 12, lost: 14, league: 1, group: "Relegation Round", form: "DDWLW"),
            Standing(id: 109, rank: 9, teamName: "광주 FC", points: 47, goalsDiff: -7, played: 38, won: 14, draw: 5, lost: 19, league: 1, group: "Relegation Round", form: "LLDDW"),
            Standing(id: 110, rank: 10, teamName: "전북 현대", points: 42, goalsDiff: -10, played: 38, won: 10, draw: 12, lost: 16, league: 1, group: "Relegation Round", form: "WLLWL"),
            Standing(id: 111, rank: 11, teamName: "대구 FC", points: 40, goalsDiff: -7, played: 38, won: 9, draw: 13, lost: 16, league: 1, group: "Relegation Round", form: "LDWLL"),
            Standing(id: 112, rank: 12, teamName: "FC 안양", points: 35, goalsDiff: -15, played: 38, won: 8, draw: 11, lost: 19, league: 1, group: "Relegation Round", form: "DLLLD")
        ]
        
        let league2 = [
            Standing(id: 201, rank: 1, teamName: "인천 유나이티드", points: 72, goalsDiff: 22, played: 36, won: 21, draw: 9, lost: 6, league: 2, group: nil, form: "WWDLW"),
            Standing(id: 202, rank: 2, teamName: "수원 삼성", points: 68, goalsDiff: 18, played: 36, won: 19, draw: 11, lost: 6, league: 2, group: nil, form: "DWLWW"),
            Standing(id: 203, rank: 3, teamName: "서울 이랜드", points: 65, goalsDiff: 15, played: 36, won: 18, draw: 11, lost: 7, league: 2, group: nil, form: "LDWDW"),
            Standing(id: 204, rank: 4, teamName: "전남 드래곤즈", points: 61, goalsDiff: 10, played: 36, won: 17, draw: 10, lost: 9, league: 2, group: nil, form: "WLDLD"),
            Standing(id: 205, rank: 5, teamName: "부산 아이파크", points: 58, goalsDiff: 8, played: 36, won: 16, draw: 10, lost: 10, league: 2, group: nil, form: "WWLDW"),
            Standing(id: 206, rank: 6, teamName: "부천 FC 1995", points: 54, goalsDiff: 4, played: 36, won: 15, draw: 9, lost: 12, league: 2, group: nil, form: "WDDDL"),
            Standing(id: 207, rank: 7, teamName: "충남아산 FC", points: 51, goalsDiff: 2, played: 36, won: 14, draw: 9, lost: 13, league: 2, group: nil, form: "WLWLL"),
            Standing(id: 208, rank: 8, teamName: "김포 FC", points: 48, goalsDiff: -2, played: 36, won: 13, draw: 9, lost: 14, league: 2, group: nil, form: "DDWLW"),
            Standing(id: 209, rank: 9, teamName: "충북청주 FC", points: 44, goalsDiff: -6, played: 36, won: 11, draw: 11, lost: 14, league: 2, group: nil, form: "LLDDW"),
            Standing(id: 210, rank: 10, teamName: "천안 시티 FC", points: 41, goalsDiff: -10, played: 36, won: 10, draw: 11, lost: 15, league: 2, group: nil, form: "WLLWL"),
            Standing(id: 211, rank: 11, teamName: "경남 FC", points: 37, goalsDiff: -15, played: 36, won: 9, draw: 10, lost: 17, league: 2, group: nil, form: "LDWLL"),
            Standing(id: 212, rank: 12, teamName: "안산 그리너스", points: 34, goalsDiff: -18, played: 36, won: 8, draw: 10, lost: 18, league: 2, group: nil, form: "DLLLD"),
            Standing(id: 213, rank: 13, teamName: "성남 FC", points: 31, goalsDiff: -22, played: 36, won: 7, draw: 10, lost: 19, league: 2, group: nil, form: "LLWWD"),
            Standing(id: 214, rank: 14, teamName: "화성 FC", points: 28, goalsDiff: -25, played: 36, won: 6, draw: 10, lost: 20, league: 2, group: nil, form: "WLDDL")
        ]
        
        return league1 + league2
    }
    
    // MARK: - 2025 시즌 선수 순위 (Player Rankings - TOP 10 풍부화)
    static var playerRankings: [PlayerRanking] {
        let goalsL1 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "주민규", teamName: "울산 HD", statCount: 16, played: 36, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "일류첸코", teamName: "FC 서울", statCount: 14, played: 35, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "야고", teamName: "울산 HD", statCount: 13, played: 34, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "이상헌", teamName: "강원 FC", statCount: 13, played: 37, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "이동경", teamName: "김천 상무", statCount: 12, played: 32, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 6, playerName: "김지현", teamName: "김천 상무", statCount: 10, played: 30, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 7, playerName: "이승우", teamName: "전북 현대", statCount: 10, played: 33, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 8, playerName: "정재희", teamName: "포항 스틸러스", statCount: 9, played: 35, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 9, playerName: "안데르손", teamName: "수원 FC", statCount: 8, played: 38, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 10, playerName: "유리 조나탄", teamName: "제주 유나이티드", statCount: 8, played: 31, league: 1, type: "goals")
        ]
        
        let assistsL1 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "안데르손", teamName: "수원 FC", statCount: 13, played: 38, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "김대원", teamName: "김천 상무", statCount: 8, played: 35, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "세징야", teamName: "대구 FC", statCount: 8, played: 32, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "황문기", teamName: "강원 FC", statCount: 7, played: 37, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "송민규", teamName: "전북 현대", statCount: 7, played: 34, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 6, playerName: "기성용", teamName: "FC 서울", statCount: 6, played: 30, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 7, playerName: "루빅손", teamName: "울산 HD", statCount: 6, played: 33, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 8, playerName: "엄원상", teamName: "울산 HD", statCount: 5, played: 31, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 9, playerName: "서진수", teamName: "제주 유나이티드", statCount: 5, played: 34, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 10, playerName: "완델손", teamName: "포항 스틸러스", statCount: 5, played: 36, league: 1, type: "assists")
        ]
        
        let goalsL2 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "무고사", teamName: "인천 유나이티드", statCount: 15, played: 36, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "뮬리치", teamName: "수원 삼성", statCount: 13, played: 32, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "루페타", teamName: "부천 FC 1995", statCount: 11, played: 31, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "호날두", teamName: "서울 이랜드", statCount: 10, played: 34, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "바사니", teamName: "부천 FC 1995", statCount: 9, played: 30, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 6, playerName: "브루노", teamName: "서울 이랜드", statCount: 8, played: 28, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 7, playerName: "페신", teamName: "부산 아이파크", statCount: 8, played: 32, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 8, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 7, played: 35, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 9, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 7, played: 30, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 10, playerName: "라마스", teamName: "부산 아이파크", statCount: 6, played: 33, league: 2, type: "goals")
        ]
        
        let assistsL2 = [
            PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 10, played: 35, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "제르소", teamName: "인천 유나이티드", statCount: 8, played: 33, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "아코스티", teamName: "수원 삼성", statCount: 7, played: 29, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "페신", teamName: "부산 아이파크", statCount: 6, played: 32, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 6, played: 30, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 6, playerName: "홍창범", teamName: "부천 FC 1995", statCount: 5, played: 33, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 7, playerName: "카즈키", teamName: "수원 삼성", statCount: 5, played: 28, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 8, playerName: "이한도", teamName: "부산 아이파크", statCount: 5, played: 34, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 9, playerName: "야고", teamName: "안산 그리너스", statCount: 4, played: 30, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 10, playerName: "김찬", teamName: "부산 아이파크", statCount: 4, played: 31, league: 2, type: "assists")
        ]
        
        return goalsL1 + assistsL1 + goalsL2 + assistsL2
    }
    
    // MARK: - 2025 시즌 경기 일정 (Match Schedules - 풍부한 데이터 세트 구성)
    static var matches: [MockMatch] {
        let league1 = [
            // Offset -3
            MockMatch(homeTeam: "제주 유나이티드", awayTeam: "대구 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "제주월드컵경기장", league: 1, dayOffset: -3),
            MockMatch(homeTeam: "강원 FC", awayTeam: "광주 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "춘천송암스포츠타운", league: 1, dayOffset: -3),
            MockMatch(homeTeam: "울산 HD", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "울산문수축구경기장", league: 1, dayOffset: -3),
            
            // Offset -2
            MockMatch(homeTeam: "대전 하나 시티즌", awayTeam: "강원 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "대전월드컵경기장", league: 1, dayOffset: -2),
            MockMatch(homeTeam: "FC 안양", awayTeam: "김천 상무", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "안양종합운동장", league: 1, dayOffset: -2),
            MockMatch(homeTeam: "수원 FC", awayTeam: "전북 현대", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "수원종합운동장", league: 1, dayOffset: -2),
            
            // Offset -1
            MockMatch(homeTeam: "FC 서울", awayTeam: "김천 상무", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "서울월드컵경기장", league: 1, dayOffset: -1),
            MockMatch(homeTeam: "울산 HD", awayTeam: "대구 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "울산문수축구경기장", league: 1, dayOffset: -1),
            MockMatch(homeTeam: "전북 현대", awayTeam: "제주 유나이티드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "전주월드컵경기장", league: 1, dayOffset: -1),
            
            // Offset 0 (목요일)
            MockMatch(homeTeam: "울산 HD", awayTeam: "전북 현대", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "울산문수축구경기장", league: 1, dayOffset: 0),
            MockMatch(homeTeam: "포항 스틸러스", awayTeam: "수원 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "포항스틸야드", league: 1, dayOffset: 0),
            MockMatch(homeTeam: "강원 FC", awayTeam: "FC 서울", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "강릉종합운동장", league: 1, dayOffset: 0),
            
            // Offset 1
            MockMatch(homeTeam: "FC 안양", awayTeam: "광주 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "안양종합운동장", league: 1, dayOffset: 1),
            MockMatch(homeTeam: "대구 FC", awayTeam: "대전 하나 시티즌", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "DGB대구은행파크", league: 1, dayOffset: 1),
            MockMatch(homeTeam: "김천 상무", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "김천종합운동장", league: 1, dayOffset: 1),
            
            // Offset 2
            MockMatch(homeTeam: "울산 HD", awayTeam: "강원 FC", homeScore: nil, awayScore: nil, status: "NS", time: "14:00", stadium: "울산문수축구경기장", league: 1, dayOffset: 2),
            MockMatch(homeTeam: "전북 현대", awayTeam: "포항 스틸러스", homeScore: nil, awayScore: nil, status: "NS", time: "16:30", stadium: "전주월드컵경기장", league: 1, dayOffset: 2),
            MockMatch(homeTeam: "FC 서울", awayTeam: "대구 FC", homeScore: nil, awayScore: nil, status: "NS", time: "19:00", stadium: "서울월드컵경기장", league: 1, dayOffset: 2),
            
            // Offset 3
            MockMatch(homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: nil, awayScore: nil, status: "NS", time: "19:00", stadium: "서울월드컵경기장", league: 1, dayOffset: 3),
            MockMatch(homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: nil, awayScore: nil, status: "NS", time: "15:00", stadium: "수원종합운동장", league: 1, dayOffset: 3),
            MockMatch(homeTeam: "김천 상무", awayTeam: "FC 안양", homeScore: nil, awayScore: nil, status: "NS", time: "17:00", stadium: "김천종합운동장", league: 1, dayOffset: 3)
        ]
        
        let league2 = [
            // Offset -3
            MockMatch(homeTeam: "부천 FC 1995", awayTeam: "수원 삼성", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "부천종합운동장", league: 2, dayOffset: -3),
            MockMatch(homeTeam: "경남 FC", awayTeam: "김포 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "창원축구센터", league: 2, dayOffset: -3),
            MockMatch(homeTeam: "전남 드래곤즈", awayTeam: "성남 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "광양축구전용구장", league: 2, dayOffset: -3),
            
            // Offset -2
            MockMatch(homeTeam: "서울 이랜드", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "목동종합운동장", league: 2, dayOffset: -2),
            MockMatch(homeTeam: "부산 아이파크", awayTeam: "충남아산 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "부산아시아드주경기장", league: 2, dayOffset: -2),
            MockMatch(homeTeam: "안산 그리너스", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "안산와스타디움", league: 2, dayOffset: -2),
            
            // Offset -1
            MockMatch(homeTeam: "인천 유나이티드", awayTeam: "부산 아이파크", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "인천축구전용경기장", league: 2, dayOffset: -1),
            MockMatch(homeTeam: "천안 시티 FC", awayTeam: "화성 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "천안종합운동장", league: 2, dayOffset: -1),
            MockMatch(homeTeam: "서울 이랜드", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "목동종합운동장", league: 2, dayOffset: -1),
            
            // Offset 0 (목요일)
            MockMatch(homeTeam: "성남 FC", awayTeam: "충남아산 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "탄천종합운동장", league: 2, dayOffset: 0),
            MockMatch(homeTeam: "김포 FC", awayTeam: "천안 시티 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "김포솔터축구장", league: 2, dayOffset: 0),
            MockMatch(homeTeam: "수원 삼성", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "수원월드컵경기장", league: 2, dayOffset: 0),
            
            // Offset 1
            MockMatch(homeTeam: "충북청주 FC", awayTeam: "안산 그리너스", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "청주종합운동장", league: 2, dayOffset: 1),
            MockMatch(homeTeam: "화성 FC", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "화성종합경기타운", league: 2, dayOffset: 1),
            MockMatch(homeTeam: "경남 FC", awayTeam: "인천 유나이티드", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "창원축구센터", league: 2, dayOffset: 1),
            
            // Offset 2
            MockMatch(homeTeam: "화성 FC", awayTeam: "경남 FC", homeScore: nil, awayScore: nil, status: "NS", time: "16:30", stadium: "화성종합경기타운", league: 2, dayOffset: 2),
            MockMatch(homeTeam: "부산 아이파크", awayTeam: "수원 삼성", homeScore: nil, awayScore: nil, status: "NS", time: "14:00", stadium: "부산아시아드주경기장", league: 2, dayOffset: 2),
            MockMatch(homeTeam: "김포 FC", awayTeam: "서울 이랜드", homeScore: nil, awayScore: nil, status: "NS", time: "19:30", stadium: "김포솔터축구장", league: 2, dayOffset: 2),
            
            // Offset 3
            MockMatch(homeTeam: "수원 삼성", awayTeam: "서울 이랜드", homeScore: nil, awayScore: nil, status: "NS", time: "19:30", stadium: "수원월드컵경기장", league: 2, dayOffset: 3),
            MockMatch(homeTeam: "충남아산 FC", awayTeam: "충북청주 FC", homeScore: nil, awayScore: nil, status: "NS", time: "14:00", stadium: "이순신종합운동장", league: 2, dayOffset: 3),
            MockMatch(homeTeam: "전남 드래곤즈", awayTeam: "천안 시티 FC", homeScore: nil, awayScore: nil, status: "NS", time: "16:30", stadium: "광양축구전용구장", league: 2, dayOffset: 3)
        ]
        
        return league1 + league2
    }
}
