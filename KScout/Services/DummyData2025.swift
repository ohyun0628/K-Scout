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
            PlayerRanking(id: 34427, rank: 1, playerName: "주민규", teamName: "울산 HD", statCount: 16, played: 36, league: 1, type: "goals"),
            PlayerRanking(id: 25276, rank: 2, playerName: "일류첸코", teamName: "FC 서울", statCount: 14, played: 35, league: 1, type: "goals"),
            PlayerRanking(id: 35821, rank: 3, playerName: "야고", teamName: "울산 HD", statCount: 13, played: 34, league: 1, type: "goals"),
            PlayerRanking(id: 292850, rank: 4, playerName: "이상헌", teamName: "강원 FC", statCount: 13, played: 37, league: 1, type: "goals"),
            PlayerRanking(id: 34431, rank: 5, playerName: "이동경", teamName: "김천 상무", statCount: 12, played: 32, league: 1, type: "goals"),
            PlayerRanking(id: 114674, rank: 6, playerName: "김지현", teamName: "김천 상무", statCount: 10, played: 30, league: 1, type: "goals"),
            PlayerRanking(id: 2914, rank: 7, playerName: "이승우", teamName: "전북 현대", statCount: 10, played: 33, league: 1, type: "goals"),
            PlayerRanking(id: -723057, rank: 8, playerName: "정재희", teamName: "포항 스틸러스", statCount: 9, played: 35, league: 1, type: "goals"),
            PlayerRanking(id: 9292, rank: 9, playerName: "안데르손", teamName: "수원 FC", statCount: 8, played: 38, league: 1, type: "goals"),
            PlayerRanking(id: 109209, rank: 10, playerName: "유리 조나탄", teamName: "제주 유나이티드", statCount: 8, played: 31, league: 1, type: "goals")
        ]
        
        let assistsL1 = [
            PlayerRanking(id: 9292, rank: 1, playerName: "안데르손", teamName: "수원 FC", statCount: 13, played: 38, league: 1, type: "assists"),
            PlayerRanking(id: -518415, rank: 2, playerName: "김대원", teamName: "김천 상무", statCount: 8, played: 35, league: 1, type: "assists"),
            PlayerRanking(id: 34484, rank: 3, playerName: "세징야", teamName: "대구 FC", statCount: 8, played: 32, league: 1, type: "assists"),
            PlayerRanking(id: 142145, rank: 4, playerName: "황문기", teamName: "강원 FC", statCount: 7, played: 37, league: 1, type: "assists"),
            PlayerRanking(id: 34598, rank: 5, playerName: "송민규", teamName: "전북 현대", statCount: 7, played: 34, league: 1, type: "assists"),
            PlayerRanking(id: -1064184, rank: 6, playerName: "기성용", teamName: "FC 서울", statCount: 6, played: 30, league: 1, type: "assists"),
            PlayerRanking(id: -1003419, rank: 7, playerName: "루빅손", teamName: "울산 HD", statCount: 6, played: 33, league: 1, type: "assists"),
            PlayerRanking(id: -630072, rank: 8, playerName: "엄원상", teamName: "울산 HD", statCount: 5, played: 31, league: 1, type: "assists"),
            PlayerRanking(id: -899182, rank: 9, playerName: "서진수", teamName: "제주 유나이티드", statCount: 5, played: 34, league: 1, type: "assists"),
            PlayerRanking(id: 34569, rank: 10, playerName: "완델손", teamName: "포항 스틸러스", statCount: 5, played: 36, league: 1, type: "assists")
        ]
        
        let goalsL2 = [
            PlayerRanking(id: 34822, rank: 1, playerName: "무고사", teamName: "인천 유나이티드", statCount: 15, played: 36, league: 2, type: "goals"),
            PlayerRanking(id: 79138, rank: 2, playerName: "뮬리치", teamName: "수원 삼성", statCount: 13, played: 32, league: 2, type: "goals"),
            PlayerRanking(id: -975524, rank: 3, playerName: "루페타", teamName: "부천 FC 1995", statCount: 11, played: 31, league: 2, type: "goals"),
            PlayerRanking(id: -396033, rank: 4, playerName: "호날두", teamName: "서울 이랜드", statCount: 10, played: 34, league: 2, type: "goals"),
            PlayerRanking(id: 143639, rank: 5, playerName: "바사니", teamName: "부천 FC 1995", statCount: 9, played: 30, league: 2, type: "goals"),
            PlayerRanking(id: -246387, rank: 6, playerName: "브루노", teamName: "서울 이랜드", statCount: 8, played: 28, league: 2, type: "goals"),
            PlayerRanking(id: -951676, rank: 7, playerName: "페신", teamName: "부산 아이파크", statCount: 8, played: 32, league: 2, type: "goals"),
            PlayerRanking(id: -725758, rank: 8, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 7, played: 35, league: 2, type: "goals"),
            PlayerRanking(id: 47757, rank: 9, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 7, played: 30, league: 2, type: "goals"),
            PlayerRanking(id: -754565, rank: 10, playerName: "라마스", teamName: "부산 아이파크", statCount: 6, played: 33, league: 2, type: "goals")
        ]
        
        let assistsL2 = [
            PlayerRanking(id: -381732, rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 10, played: 35, league: 2, type: "assists"),
            PlayerRanking(id: 51267, rank: 2, playerName: "제르소", teamName: "인천 유나이티드", statCount: 8, played: 33, league: 2, type: "assists"),
            PlayerRanking(id: -855144, rank: 3, playerName: "아코스티", teamName: "수원 삼성", statCount: 7, played: 29, league: 2, type: "assists"),
            PlayerRanking(id: -1084427, rank: 4, playerName: "페신", teamName: "부산 아이파크", statCount: 6, played: 32, league: 2, type: "assists"),
            PlayerRanking(id: 47757, rank: 5, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 6, played: 30, league: 2, type: "assists"),
            PlayerRanking(id: -646214, rank: 6, playerName: "홍창범", teamName: "부천 FC 1995", statCount: 5, played: 33, league: 2, type: "assists"),
            PlayerRanking(id: -900934, rank: 7, playerName: "카즈키", teamName: "수원 삼성", statCount: 5, played: 28, league: 2, type: "assists"),
            PlayerRanking(id: -593820, rank: 8, playerName: "이한도", teamName: "부산 아이파크", statCount: 5, played: 34, league: 2, type: "assists"),
            PlayerRanking(id: 35821, rank: 9, playerName: "야고", teamName: "안산 그리너스", statCount: 4, played: 30, league: 2, type: "assists"),
            PlayerRanking(id: -1082268, rank: 10, playerName: "김찬", teamName: "부산 아이파크", statCount: 4, played: 31, league: 2, type: "assists")
        ]
        
        let allRankings = goalsL1 + assistsL1 + goalsL2 + assistsL2
        return allRankings.map { r in
            PlayerRanking(
                id: r.id,
                rank: r.rank,
                playerName: r.playerName,
                teamName: r.teamName,
                statCount: r.statCount,
                played: r.played,
                league: r.league,
                type: r.type,
                photoURL: resolvedPlayerPhotoURL(for: r.playerName) ?? r.photoURL,
                goals: r.goals,
                assists: r.assists,
                attackPoints: r.attackPoints,
                momCount: r.momCount,
                avgRating: r.avgRating,
                best11Count: r.best11Count,
                goalsPer90: r.goalsPer90,
                pointsPer90: r.pointsPer90,
                shots: r.shots,
                shotsOnTarget: r.shotsOnTarget,
                playedMinutes: r.playedMinutes,
                pkGoals: r.pkGoals,
                fouls: r.fouls,
                yellowCards: r.yellowCards
            )
        }
    }
    
    // MARK: - 2025 시즌 경기 일정 (Match Schedules - 풍부한 데이터 세트 구성)
        static var matches: [MockMatch] {
        var allMatches: [MockMatch] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        allMatches.append(MockMatch(apiId: 37504, homeTeam: "울산 HD", awayTeam: "FC 안양", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-02"))
        allMatches.append(MockMatch(apiId: 26607, homeTeam: "포항 스틸러스", awayTeam: "대구 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-02"))
        allMatches.append(MockMatch(apiId: 57275, homeTeam: "김천 상무", awayTeam: "전북 현대", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 75800, homeTeam: "강원 FC", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 29592, homeTeam: "FC 서울", awayTeam: "제주 유나이티드", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 28036, homeTeam: "수원 FC", awayTeam: "광주 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 48763, homeTeam: "대구 FC", awayTeam: "울산 HD", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 27559, homeTeam: "전북 현대", awayTeam: "FC 안양", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 41657, homeTeam: "대전 하나 시티즌", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-08"))
        allMatches.append(MockMatch(apiId: 44019, homeTeam: "제주 유나이티드", awayTeam: "김천 상무", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 51410, homeTeam: "광주 FC", awayTeam: "강원 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-08"))
        allMatches.append(MockMatch(apiId: 57311, homeTeam: "수원 FC", awayTeam: "FC 서울", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 53175, homeTeam: "울산 HD", awayTeam: "전북 현대", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 80520, homeTeam: "대구 FC", awayTeam: "대전 하나 시티즌", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 54909, homeTeam: "FC 안양", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 12090, homeTeam: "포항 스틸러스", awayTeam: "광주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 88818, homeTeam: "김천 상무", awayTeam: "수원 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 46049, homeTeam: "강원 FC", awayTeam: "FC 서울", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-15"))
        allMatches.append(MockMatch(apiId: 62384, homeTeam: "대전 하나 시티즌", awayTeam: "울산 HD", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 64940, homeTeam: "제주 유나이티드", awayTeam: "전북 현대", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 41875, homeTeam: "광주 FC", awayTeam: "대구 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 76238, homeTeam: "수원 FC", awayTeam: "FC 안양", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 13531, homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 26452, homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 82348, homeTeam: "울산 HD", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 80260, homeTeam: "대전 하나 시티즌", awayTeam: "광주 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 76142, homeTeam: "전북 현대", awayTeam: "수원 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 53874, homeTeam: "대구 FC", awayTeam: "FC 서울", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 12791, homeTeam: "FC 안양", awayTeam: "강원 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 61430, homeTeam: "포항 스틸러스", awayTeam: "김천 상무", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 18940, homeTeam: "광주 FC", awayTeam: "울산 HD", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 77601, homeTeam: "수원 FC", awayTeam: "제주 유나이티드", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 56478, homeTeam: "FC 서울", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 19331, homeTeam: "강원 FC", awayTeam: "전북 현대", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 87634, homeTeam: "김천 상무", awayTeam: "대구 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 36561, homeTeam: "포항 스틸러스", awayTeam: "FC 안양", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 69561, homeTeam: "울산 HD", awayTeam: "수원 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 49978, homeTeam: "광주 FC", awayTeam: "FC 서울", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 70001, homeTeam: "제주 유나이티드", awayTeam: "강원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-13"))
        allMatches.append(MockMatch(apiId: 10421, homeTeam: "대전 하나 시티즌", awayTeam: "김천 상무", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 69504, homeTeam: "전북 현대", awayTeam: "포항 스틸러스", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 73423, homeTeam: "대구 FC", awayTeam: "FC 안양", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 71310, homeTeam: "FC 서울", awayTeam: "울산 HD", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-20"))
        allMatches.append(MockMatch(apiId: 38739, homeTeam: "강원 FC", awayTeam: "수원 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 20687, homeTeam: "김천 상무", awayTeam: "광주 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 53504, homeTeam: "포항 스틸러스", awayTeam: "제주 유나이티드", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-20"))
        allMatches.append(MockMatch(apiId: 50975, homeTeam: "FC 안양", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 63412, homeTeam: "대구 FC", awayTeam: "전북 현대", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-20"))
        allMatches.append(MockMatch(apiId: 32341, homeTeam: "울산 HD", awayTeam: "강원 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 69609, homeTeam: "FC 서울", awayTeam: "김천 상무", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 26400, homeTeam: "수원 FC", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 85508, homeTeam: "광주 FC", awayTeam: "FC 안양", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 45799, homeTeam: "제주 유나이티드", awayTeam: "대구 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-27"))
        allMatches.append(MockMatch(apiId: 41416, homeTeam: "대전 하나 시티즌", awayTeam: "전북 현대", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 35885, homeTeam: "김천 상무", awayTeam: "울산 HD", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-04"))
        allMatches.append(MockMatch(apiId: 14398, homeTeam: "포항 스틸러스", awayTeam: "강원 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-04"))
        allMatches.append(MockMatch(apiId: 29492, homeTeam: "FC 안양", awayTeam: "FC 서울", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-04"))
        allMatches.append(MockMatch(apiId: 38073, homeTeam: "대구 FC", awayTeam: "수원 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 53904, homeTeam: "전북 현대", awayTeam: "광주 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 56343, homeTeam: "대전 하나 시티즌", awayTeam: "제주 유나이티드", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 67047, homeTeam: "울산 HD", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 81319, homeTeam: "김천 상무", awayTeam: "FC 안양", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-11"))
        allMatches.append(MockMatch(apiId: 73528, homeTeam: "강원 FC", awayTeam: "대구 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-11"))
        allMatches.append(MockMatch(apiId: 67047, homeTeam: "FC 서울", awayTeam: "전북 현대", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 40172, homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-11"))
        allMatches.append(MockMatch(apiId: 84792, homeTeam: "광주 FC", awayTeam: "제주 유나이티드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 10029, homeTeam: "FC 안양", awayTeam: "울산 HD", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-18"))
        allMatches.append(MockMatch(apiId: 36531, homeTeam: "대구 FC", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 15482, homeTeam: "전북 현대", awayTeam: "김천 상무", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-18"))
        allMatches.append(MockMatch(apiId: 79019, homeTeam: "대전 하나 시티즌", awayTeam: "강원 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 75445, homeTeam: "제주 유나이티드", awayTeam: "FC 서울", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-18"))
        allMatches.append(MockMatch(apiId: 48496, homeTeam: "광주 FC", awayTeam: "수원 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 46741, homeTeam: "울산 HD", awayTeam: "대구 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-24"))
        allMatches.append(MockMatch(apiId: 47474, homeTeam: "FC 안양", awayTeam: "전북 현대", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 17560, homeTeam: "포항 스틸러스", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 50790, homeTeam: "김천 상무", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-24"))
        allMatches.append(MockMatch(apiId: 21354, homeTeam: "강원 FC", awayTeam: "광주 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 85160, homeTeam: "FC 서울", awayTeam: "수원 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 87304, homeTeam: "전북 현대", awayTeam: "울산 HD", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 58160, homeTeam: "대전 하나 시티즌", awayTeam: "대구 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 65100, homeTeam: "제주 유나이티드", awayTeam: "FC 안양", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-31"))
        allMatches.append(MockMatch(apiId: 85329, homeTeam: "광주 FC", awayTeam: "포항 스틸러스", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-05-31"))
        allMatches.append(MockMatch(apiId: 73681, homeTeam: "수원 FC", awayTeam: "김천 상무", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 28946, homeTeam: "FC 서울", awayTeam: "강원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 85953, homeTeam: "울산 HD", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 52939, homeTeam: "전북 현대", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-08"))
        allMatches.append(MockMatch(apiId: 14930, homeTeam: "대구 FC", awayTeam: "광주 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 76554, homeTeam: "FC 안양", awayTeam: "수원 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 23057, homeTeam: "포항 스틸러스", awayTeam: "FC 서울", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-08"))
        allMatches.append(MockMatch(apiId: 60264, homeTeam: "김천 상무", awayTeam: "강원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 74417, homeTeam: "제주 유나이티드", awayTeam: "울산 HD", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 34120, homeTeam: "광주 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 31786, homeTeam: "수원 FC", awayTeam: "전북 현대", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 88329, homeTeam: "FC 서울", awayTeam: "대구 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 30252, homeTeam: "강원 FC", awayTeam: "FC 안양", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 79590, homeTeam: "김천 상무", awayTeam: "포항 스틸러스", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 55761, homeTeam: "울산 HD", awayTeam: "광주 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 77623, homeTeam: "제주 유나이티드", awayTeam: "수원 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 37891, homeTeam: "대전 하나 시티즌", awayTeam: "FC 서울", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 43526, homeTeam: "전북 현대", awayTeam: "강원 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 77262, homeTeam: "대구 FC", awayTeam: "김천 상무", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 12419, homeTeam: "FC 안양", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 23350, homeTeam: "수원 FC", awayTeam: "울산 HD", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-29"))
        allMatches.append(MockMatch(apiId: 52113, homeTeam: "FC 서울", awayTeam: "광주 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-29"))
        allMatches.append(MockMatch(apiId: 58891, homeTeam: "강원 FC", awayTeam: "제주 유나이티드", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 31216, homeTeam: "김천 상무", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 39975, homeTeam: "포항 스틸러스", awayTeam: "전북 현대", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 81593, homeTeam: "FC 안양", awayTeam: "대구 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 33050, homeTeam: "울산 HD", awayTeam: "FC 서울", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 10411, homeTeam: "수원 FC", awayTeam: "강원 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-06"))
        allMatches.append(MockMatch(apiId: 17170, homeTeam: "광주 FC", awayTeam: "김천 상무", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 18422, homeTeam: "제주 유나이티드", awayTeam: "포항 스틸러스", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 65827, homeTeam: "대전 하나 시티즌", awayTeam: "FC 안양", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 62339, homeTeam: "전북 현대", awayTeam: "대구 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 11331, homeTeam: "강원 FC", awayTeam: "울산 HD", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 21714, homeTeam: "김천 상무", awayTeam: "FC 서울", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-13"))
        allMatches.append(MockMatch(apiId: 11241, homeTeam: "포항 스틸러스", awayTeam: "수원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 75447, homeTeam: "FC 안양", awayTeam: "광주 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-13"))
        allMatches.append(MockMatch(apiId: 43254, homeTeam: "대구 FC", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 83522, homeTeam: "전북 현대", awayTeam: "대전 하나 시티즌", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-13"))
        allMatches.append(MockMatch(apiId: 61600, homeTeam: "울산 HD", awayTeam: "김천 상무", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 53984, homeTeam: "강원 FC", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 17778, homeTeam: "FC 서울", awayTeam: "FC 안양", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 88500, homeTeam: "수원 FC", awayTeam: "대구 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 45497, homeTeam: "광주 FC", awayTeam: "전북 현대", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 54549, homeTeam: "제주 유나이티드", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 17926, homeTeam: "포항 스틸러스", awayTeam: "울산 HD", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 85165, homeTeam: "FC 안양", awayTeam: "김천 상무", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 41411, homeTeam: "대구 FC", awayTeam: "강원 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-26"))
        allMatches.append(MockMatch(apiId: 53543, homeTeam: "전북 현대", awayTeam: "FC 서울", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 79156, homeTeam: "대전 하나 시티즌", awayTeam: "수원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-26"))
        allMatches.append(MockMatch(apiId: 48729, homeTeam: "제주 유나이티드", awayTeam: "광주 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 81634, homeTeam: "울산 HD", awayTeam: "FC 안양", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 39309, homeTeam: "포항 스틸러스", awayTeam: "대구 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 13680, homeTeam: "김천 상무", awayTeam: "전북 현대", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 46263, homeTeam: "강원 FC", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 64014, homeTeam: "FC 서울", awayTeam: "제주 유나이티드", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 20878, homeTeam: "수원 FC", awayTeam: "광주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 80012, homeTeam: "대구 FC", awayTeam: "울산 HD", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 72949, homeTeam: "전북 현대", awayTeam: "FC 안양", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 19164, homeTeam: "대전 하나 시티즌", awayTeam: "포항 스틸러스", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 38883, homeTeam: "제주 유나이티드", awayTeam: "김천 상무", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 67958, homeTeam: "광주 FC", awayTeam: "강원 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 51333, homeTeam: "수원 FC", awayTeam: "FC 서울", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-10"))
        allMatches.append(MockMatch(apiId: 83454, homeTeam: "울산 HD", awayTeam: "전북 현대", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 80610, homeTeam: "대구 FC", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-17"))
        allMatches.append(MockMatch(apiId: 57169, homeTeam: "FC 안양", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 19561, homeTeam: "포항 스틸러스", awayTeam: "광주 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 13465, homeTeam: "김천 상무", awayTeam: "수원 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 45358, homeTeam: "강원 FC", awayTeam: "FC 서울", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 48332, homeTeam: "대전 하나 시티즌", awayTeam: "울산 HD", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 26315, homeTeam: "제주 유나이티드", awayTeam: "전북 현대", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 21625, homeTeam: "광주 FC", awayTeam: "대구 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-24"))
        allMatches.append(MockMatch(apiId: 17167, homeTeam: "수원 FC", awayTeam: "FC 안양", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 43879, homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 55885, homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 78855, homeTeam: "울산 HD", awayTeam: "제주 유나이티드", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 27792, homeTeam: "대전 하나 시티즌", awayTeam: "광주 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-30"))
        allMatches.append(MockMatch(apiId: 11614, homeTeam: "전북 현대", awayTeam: "수원 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 77685, homeTeam: "대구 FC", awayTeam: "FC 서울", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-30"))
        allMatches.append(MockMatch(apiId: 54705, homeTeam: "FC 안양", awayTeam: "강원 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 22175, homeTeam: "포항 스틸러스", awayTeam: "김천 상무", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-08-30"))
        allMatches.append(MockMatch(apiId: 62565, homeTeam: "광주 FC", awayTeam: "울산 HD", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 30031, homeTeam: "수원 FC", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 78233, homeTeam: "FC 서울", awayTeam: "대전 하나 시티즌", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-07"))
        allMatches.append(MockMatch(apiId: 19259, homeTeam: "강원 FC", awayTeam: "전북 현대", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-07"))
        allMatches.append(MockMatch(apiId: 40145, homeTeam: "김천 상무", awayTeam: "대구 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 54241, homeTeam: "포항 스틸러스", awayTeam: "FC 안양", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 10457, homeTeam: "울산 HD", awayTeam: "수원 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-14"))
        allMatches.append(MockMatch(apiId: 39104, homeTeam: "광주 FC", awayTeam: "FC 서울", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 48304, homeTeam: "제주 유나이티드", awayTeam: "강원 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 43414, homeTeam: "대전 하나 시티즌", awayTeam: "김천 상무", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-14"))
        allMatches.append(MockMatch(apiId: 64275, homeTeam: "전북 현대", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 53695, homeTeam: "대구 FC", awayTeam: "FC 안양", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 25425, homeTeam: "FC 서울", awayTeam: "울산 HD", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 70758, homeTeam: "강원 FC", awayTeam: "수원 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-20"))
        allMatches.append(MockMatch(apiId: 26645, homeTeam: "김천 상무", awayTeam: "광주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-20"))
        allMatches.append(MockMatch(apiId: 20997, homeTeam: "포항 스틸러스", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-20"))
        allMatches.append(MockMatch(apiId: 72681, homeTeam: "FC 안양", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 72221, homeTeam: "대구 FC", awayTeam: "전북 현대", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 80739, homeTeam: "울산 HD", awayTeam: "강원 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 18038, homeTeam: "FC 서울", awayTeam: "김천 상무", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 52116, homeTeam: "수원 FC", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 67800, homeTeam: "광주 FC", awayTeam: "FC 안양", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 40102, homeTeam: "제주 유나이티드", awayTeam: "대구 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 88283, homeTeam: "대전 하나 시티즌", awayTeam: "전북 현대", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 56198, homeTeam: "김천 상무", awayTeam: "울산 HD", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 16898, homeTeam: "포항 스틸러스", awayTeam: "강원 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-05"))
        allMatches.append(MockMatch(apiId: 47427, homeTeam: "FC 안양", awayTeam: "FC 서울", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 20045, homeTeam: "대구 FC", awayTeam: "수원 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-05"))
        allMatches.append(MockMatch(apiId: 37594, homeTeam: "전북 현대", awayTeam: "광주 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-05"))
        allMatches.append(MockMatch(apiId: 52213, homeTeam: "대전 하나 시티즌", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 59109, homeTeam: "울산 HD", awayTeam: "포항 스틸러스", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-11"))
        allMatches.append(MockMatch(apiId: 29393, homeTeam: "김천 상무", awayTeam: "FC 안양", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 70472, homeTeam: "강원 FC", awayTeam: "대구 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-11"))
        allMatches.append(MockMatch(apiId: 35570, homeTeam: "FC 서울", awayTeam: "전북 현대", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 42331, homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-11"))
        allMatches.append(MockMatch(apiId: 54980, homeTeam: "광주 FC", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 28392, homeTeam: "FC 안양", awayTeam: "울산 HD", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 28054, homeTeam: "대구 FC", awayTeam: "포항 스틸러스", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 71334, homeTeam: "전북 현대", awayTeam: "김천 상무", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 40517, homeTeam: "대전 하나 시티즌", awayTeam: "강원 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-18"))
        allMatches.append(MockMatch(apiId: 44892, homeTeam: "제주 유나이티드", awayTeam: "FC 서울", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-18"))
        allMatches.append(MockMatch(apiId: 29295, homeTeam: "광주 FC", awayTeam: "수원 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-18"))
        allMatches.append(MockMatch(apiId: 29752, homeTeam: "울산 HD", awayTeam: "대구 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-26"))
        allMatches.append(MockMatch(apiId: 53489, homeTeam: "FC 안양", awayTeam: "전북 현대", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 15403, homeTeam: "포항 스틸러스", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 52933, homeTeam: "김천 상무", awayTeam: "제주 유나이티드", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-26"))
        allMatches.append(MockMatch(apiId: 60783, homeTeam: "강원 FC", awayTeam: "광주 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-26"))
        allMatches.append(MockMatch(apiId: 13655, homeTeam: "FC 서울", awayTeam: "수원 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-10-26"))
        allMatches.append(MockMatch(apiId: 38599, homeTeam: "전북 현대", awayTeam: "울산 HD", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 38226, homeTeam: "대전 하나 시티즌", awayTeam: "대구 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "대전 하나 시티즌 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 70433, homeTeam: "제주 유나이티드", awayTeam: "FC 안양", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-02"))
        allMatches.append(MockMatch(apiId: 68257, homeTeam: "광주 FC", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-02"))
        allMatches.append(MockMatch(apiId: 20592, homeTeam: "수원 FC", awayTeam: "김천 상무", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 54491, homeTeam: "FC 서울", awayTeam: "강원 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 11877, homeTeam: "울산 HD", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "울산 HD 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 21507, homeTeam: "전북 현대", awayTeam: "제주 유나이티드", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "전북 현대 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 32837, homeTeam: "대구 FC", awayTeam: "광주 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "대구 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-08"))
        allMatches.append(MockMatch(apiId: 16727, homeTeam: "FC 안양", awayTeam: "수원 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "FC 안양 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 13196, homeTeam: "포항 스틸러스", awayTeam: "FC 서울", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "포항 스틸러스 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-08"))
        allMatches.append(MockMatch(apiId: 40155, homeTeam: "김천 상무", awayTeam: "강원 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-08"))
        allMatches.append(MockMatch(apiId: 71383, homeTeam: "제주 유나이티드", awayTeam: "울산 HD", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "제주 유나이티드 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 25189, homeTeam: "광주 FC", awayTeam: "대전 하나 시티즌", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "광주 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 26352, homeTeam: "수원 FC", awayTeam: "전북 현대", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "수원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-15"))
        allMatches.append(MockMatch(apiId: 21270, homeTeam: "FC 서울", awayTeam: "대구 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "FC 서울 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-15"))
        allMatches.append(MockMatch(apiId: 43503, homeTeam: "강원 FC", awayTeam: "FC 안양", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "강원 FC 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-15"))
        allMatches.append(MockMatch(apiId: 13590, homeTeam: "김천 상무", awayTeam: "포항 스틸러스", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "김천 상무 홈경기장", league: 1, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 65696, homeTeam: "수원 삼성", awayTeam: "성남 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 76168, homeTeam: "서울 이랜드", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-02"))
        allMatches.append(MockMatch(apiId: 54765, homeTeam: "전남 드래곤즈", awayTeam: "경남 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 81955, homeTeam: "부산 아이파크", awayTeam: "천안 시티 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-02"))
        allMatches.append(MockMatch(apiId: 82293, homeTeam: "부천 FC 1995", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-02"))
        allMatches.append(MockMatch(apiId: 19207, homeTeam: "충남아산 FC", awayTeam: "김포 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-01"))
        allMatches.append(MockMatch(apiId: 15697, homeTeam: "성남 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-08"))
        allMatches.append(MockMatch(apiId: 12444, homeTeam: "경남 FC", awayTeam: "수원 삼성", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-08"))
        allMatches.append(MockMatch(apiId: 38623, homeTeam: "천안 시티 FC", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 36394, homeTeam: "충북청주 FC", awayTeam: "전남 드래곤즈", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 33596, homeTeam: "김포 FC", awayTeam: "부산 아이파크", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-09"))
        allMatches.append(MockMatch(apiId: 58026, homeTeam: "충남아산 FC", awayTeam: "부천 FC 1995", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-08"))
        allMatches.append(MockMatch(apiId: 58469, homeTeam: "인천 유나이티드", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 83295, homeTeam: "성남 FC", awayTeam: "경남 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 29024, homeTeam: "수원 삼성", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 63114, homeTeam: "서울 이랜드", awayTeam: "김포 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-15"))
        allMatches.append(MockMatch(apiId: 80106, homeTeam: "전남 드래곤즈", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-15"))
        allMatches.append(MockMatch(apiId: 41585, homeTeam: "부산 아이파크", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-16"))
        allMatches.append(MockMatch(apiId: 77012, homeTeam: "경남 FC", awayTeam: "인천 유나이티드", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 46339, homeTeam: "천안 시티 FC", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 65653, homeTeam: "충북청주 FC", awayTeam: "성남 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 58293, homeTeam: "충남아산 FC", awayTeam: "수원 삼성", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 17500, homeTeam: "부천 FC 1995", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-22"))
        allMatches.append(MockMatch(apiId: 61207, homeTeam: "부산 아이파크", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-23"))
        allMatches.append(MockMatch(apiId: 36464, homeTeam: "인천 유나이티드", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 82442, homeTeam: "경남 FC", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 40514, homeTeam: "안산 그리너스", awayTeam: "김포 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 14286, homeTeam: "성남 FC", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-29"))
        allMatches.append(MockMatch(apiId: 75397, homeTeam: "수원 삼성", awayTeam: "부산 아이파크", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 52154, homeTeam: "서울 이랜드", awayTeam: "전남 드래곤즈", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-03-30"))
        allMatches.append(MockMatch(apiId: 77812, homeTeam: "충북청주 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-06"))
        allMatches.append(MockMatch(apiId: 23202, homeTeam: "김포 FC", awayTeam: "천안 시티 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 70361, homeTeam: "충남아산 FC", awayTeam: "경남 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 88190, homeTeam: "부천 FC 1995", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 34490, homeTeam: "부산 아이파크", awayTeam: "성남 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-06"))
        allMatches.append(MockMatch(apiId: 78390, homeTeam: "서울 이랜드", awayTeam: "수원 삼성", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-05"))
        allMatches.append(MockMatch(apiId: 39464, homeTeam: "인천 유나이티드", awayTeam: "김포 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 40676, homeTeam: "충북청주 FC", awayTeam: "충남아산 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-13"))
        allMatches.append(MockMatch(apiId: 83899, homeTeam: "천안 시티 FC", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 31729, homeTeam: "경남 FC", awayTeam: "부산 아이파크", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 29562, homeTeam: "안산 그리너스", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-12"))
        allMatches.append(MockMatch(apiId: 46603, homeTeam: "성남 FC", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-13"))
        allMatches.append(MockMatch(apiId: 30976, homeTeam: "충남아산 FC", awayTeam: "인천 유나이티드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 27183, homeTeam: "부천 FC 1995", awayTeam: "김포 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 67042, homeTeam: "부산 아이파크", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 49325, homeTeam: "전남 드래곤즈", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-20"))
        allMatches.append(MockMatch(apiId: 87361, homeTeam: "서울 이랜드", awayTeam: "경남 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-19"))
        allMatches.append(MockMatch(apiId: 39002, homeTeam: "수원 삼성", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-20"))
        allMatches.append(MockMatch(apiId: 37500, homeTeam: "인천 유나이티드", awayTeam: "부천 FC 1995", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 31399, homeTeam: "충남아산 FC", awayTeam: "부산 아이파크", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 28798, homeTeam: "김포 FC", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 36564, homeTeam: "충북청주 FC", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 37733, homeTeam: "천안 시티 FC", awayTeam: "수원 삼성", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 26126, homeTeam: "안산 그리너스", awayTeam: "성남 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-04-26"))
        allMatches.append(MockMatch(apiId: 40353, homeTeam: "부산 아이파크", awayTeam: "인천 유나이티드", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 19363, homeTeam: "전남 드래곤즈", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 89605, homeTeam: "서울 이랜드", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-04"))
        allMatches.append(MockMatch(apiId: 38895, homeTeam: "수원 삼성", awayTeam: "김포 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 34913, homeTeam: "성남 FC", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 67503, homeTeam: "안산 그리너스", awayTeam: "경남 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-03"))
        allMatches.append(MockMatch(apiId: 81209, homeTeam: "인천 유나이티드", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 37141, homeTeam: "부산 아이파크", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-11"))
        allMatches.append(MockMatch(apiId: 25076, homeTeam: "부천 FC 1995", awayTeam: "수원 삼성", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-11"))
        allMatches.append(MockMatch(apiId: 31630, homeTeam: "김포 FC", awayTeam: "성남 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 79568, homeTeam: "충북청주 FC", awayTeam: "안산 그리너스", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 87170, homeTeam: "천안 시티 FC", awayTeam: "경남 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-10"))
        allMatches.append(MockMatch(apiId: 45057, homeTeam: "서울 이랜드", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 32112, homeTeam: "수원 삼성", awayTeam: "전남 드래곤즈", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-18"))
        allMatches.append(MockMatch(apiId: 58409, homeTeam: "성남 FC", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 55606, homeTeam: "안산 그리너스", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 34919, homeTeam: "경남 FC", awayTeam: "김포 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-18"))
        allMatches.append(MockMatch(apiId: 29978, homeTeam: "천안 시티 FC", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-17"))
        allMatches.append(MockMatch(apiId: 36209, homeTeam: "인천 유나이티드", awayTeam: "수원 삼성", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 67865, homeTeam: "전남 드래곤즈", awayTeam: "성남 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 25962, homeTeam: "부산 아이파크", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-24"))
        allMatches.append(MockMatch(apiId: 17033, homeTeam: "부천 FC 1995", awayTeam: "경남 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 30716, homeTeam: "충남아산 FC", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-25"))
        allMatches.append(MockMatch(apiId: 62471, homeTeam: "김포 FC", awayTeam: "충북청주 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-24"))
        allMatches.append(MockMatch(apiId: 57529, homeTeam: "성남 FC", awayTeam: "수원 삼성", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 49675, homeTeam: "안산 그리너스", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-31"))
        allMatches.append(MockMatch(apiId: 16902, homeTeam: "경남 FC", awayTeam: "전남 드래곤즈", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-05-31"))
        allMatches.append(MockMatch(apiId: 30316, homeTeam: "천안 시티 FC", awayTeam: "부산 아이파크", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 22622, homeTeam: "충북청주 FC", awayTeam: "부천 FC 1995", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 77071, homeTeam: "김포 FC", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-01"))
        allMatches.append(MockMatch(apiId: 56045, homeTeam: "인천 유나이티드", awayTeam: "성남 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-08"))
        allMatches.append(MockMatch(apiId: 19338, homeTeam: "수원 삼성", awayTeam: "경남 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-08"))
        allMatches.append(MockMatch(apiId: 64913, homeTeam: "서울 이랜드", awayTeam: "천안 시티 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 42895, homeTeam: "전남 드래곤즈", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-08"))
        allMatches.append(MockMatch(apiId: 22434, homeTeam: "부산 아이파크", awayTeam: "김포 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 74457, homeTeam: "부천 FC 1995", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-07"))
        allMatches.append(MockMatch(apiId: 22101, homeTeam: "안산 그리너스", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 12330, homeTeam: "경남 FC", awayTeam: "성남 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-14"))
        allMatches.append(MockMatch(apiId: 78880, homeTeam: "충북청주 FC", awayTeam: "수원 삼성", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-14"))
        allMatches.append(MockMatch(apiId: 76095, homeTeam: "김포 FC", awayTeam: "서울 이랜드", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-14"))
        allMatches.append(MockMatch(apiId: 12330, homeTeam: "충남아산 FC", awayTeam: "전남 드래곤즈", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-15"))
        allMatches.append(MockMatch(apiId: 84787, homeTeam: "부천 FC 1995", awayTeam: "부산 아이파크", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-14"))
        allMatches.append(MockMatch(apiId: 16708, homeTeam: "인천 유나이티드", awayTeam: "경남 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 27956, homeTeam: "안산 그리너스", awayTeam: "천안 시티 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 57386, homeTeam: "성남 FC", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 48466, homeTeam: "수원 삼성", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-21"))
        allMatches.append(MockMatch(apiId: 58552, homeTeam: "서울 이랜드", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 61100, homeTeam: "전남 드래곤즈", awayTeam: "부산 아이파크", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-22"))
        allMatches.append(MockMatch(apiId: 68582, homeTeam: "천안 시티 FC", awayTeam: "인천 유나이티드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-29"))
        allMatches.append(MockMatch(apiId: 29756, homeTeam: "충북청주 FC", awayTeam: "경남 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 56334, homeTeam: "김포 FC", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-29"))
        allMatches.append(MockMatch(apiId: 57757, homeTeam: "충남아산 FC", awayTeam: "성남 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-29"))
        allMatches.append(MockMatch(apiId: 43329, homeTeam: "부산 아이파크", awayTeam: "수원 삼성", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 43569, homeTeam: "전남 드래곤즈", awayTeam: "서울 이랜드", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-06-28"))
        allMatches.append(MockMatch(apiId: 18911, homeTeam: "인천 유나이티드", awayTeam: "충북청주 FC", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 20165, homeTeam: "천안 시티 FC", awayTeam: "김포 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-06"))
        allMatches.append(MockMatch(apiId: 84584, homeTeam: "경남 FC", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 58975, homeTeam: "안산 그리너스", awayTeam: "부천 FC 1995", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-06"))
        allMatches.append(MockMatch(apiId: 20891, homeTeam: "성남 FC", awayTeam: "부산 아이파크", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-06"))
        allMatches.append(MockMatch(apiId: 33176, homeTeam: "수원 삼성", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-05"))
        allMatches.append(MockMatch(apiId: 68714, homeTeam: "김포 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 77183, homeTeam: "충남아산 FC", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 84023, homeTeam: "부천 FC 1995", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 44574, homeTeam: "부산 아이파크", awayTeam: "경남 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-13"))
        allMatches.append(MockMatch(apiId: 64289, homeTeam: "전남 드래곤즈", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-12"))
        allMatches.append(MockMatch(apiId: 19791, homeTeam: "서울 이랜드", awayTeam: "성남 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-13"))
        allMatches.append(MockMatch(apiId: 87263, homeTeam: "인천 유나이티드", awayTeam: "충남아산 FC", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 87025, homeTeam: "김포 FC", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 56943, homeTeam: "충북청주 FC", awayTeam: "부산 아이파크", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-20"))
        allMatches.append(MockMatch(apiId: 18848, homeTeam: "천안 시티 FC", awayTeam: "전남 드래곤즈", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 52375, homeTeam: "경남 FC", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 38291, homeTeam: "안산 그리너스", awayTeam: "수원 삼성", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-19"))
        allMatches.append(MockMatch(apiId: 20802, homeTeam: "부천 FC 1995", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 73169, homeTeam: "부산 아이파크", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 79990, homeTeam: "전남 드래곤즈", awayTeam: "김포 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 27966, homeTeam: "서울 이랜드", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 71467, homeTeam: "수원 삼성", awayTeam: "천안 시티 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-26"))
        allMatches.append(MockMatch(apiId: 72248, homeTeam: "성남 FC", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-07-27"))
        allMatches.append(MockMatch(apiId: 55205, homeTeam: "인천 유나이티드", awayTeam: "부산 아이파크", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 18719, homeTeam: "부천 FC 1995", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 45968, homeTeam: "충남아산 FC", awayTeam: "서울 이랜드", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-02"))
        allMatches.append(MockMatch(apiId: 61652, homeTeam: "김포 FC", awayTeam: "수원 삼성", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 69745, homeTeam: "천안 시티 FC", awayTeam: "성남 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 13499, homeTeam: "경남 FC", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-03"))
        allMatches.append(MockMatch(apiId: 28931, homeTeam: "전남 드래곤즈", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-10"))
        allMatches.append(MockMatch(apiId: 57237, homeTeam: "서울 이랜드", awayTeam: "부산 아이파크", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-10"))
        allMatches.append(MockMatch(apiId: 74155, homeTeam: "수원 삼성", awayTeam: "부천 FC 1995", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 55230, homeTeam: "성남 FC", awayTeam: "김포 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-09"))
        allMatches.append(MockMatch(apiId: 42366, homeTeam: "안산 그리너스", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-10"))
        allMatches.append(MockMatch(apiId: 79245, homeTeam: "경남 FC", awayTeam: "천안 시티 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-10"))
        allMatches.append(MockMatch(apiId: 79334, homeTeam: "인천 유나이티드", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 78151, homeTeam: "전남 드래곤즈", awayTeam: "수원 삼성", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 31807, homeTeam: "부천 FC 1995", awayTeam: "성남 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-16"))
        allMatches.append(MockMatch(apiId: 13869, homeTeam: "충남아산 FC", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-17"))
        allMatches.append(MockMatch(apiId: 51793, homeTeam: "김포 FC", awayTeam: "경남 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-17"))
        allMatches.append(MockMatch(apiId: 65318, homeTeam: "충북청주 FC", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-17"))
        allMatches.append(MockMatch(apiId: 71237, homeTeam: "수원 삼성", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 25072, homeTeam: "성남 FC", awayTeam: "전남 드래곤즈", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 32772, homeTeam: "안산 그리너스", awayTeam: "부산 아이파크", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-23"))
        allMatches.append(MockMatch(apiId: 65180, homeTeam: "경남 FC", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-24"))
        allMatches.append(MockMatch(apiId: 27937, homeTeam: "천안 시티 FC", awayTeam: "충남아산 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-24"))
        allMatches.append(MockMatch(apiId: 82034, homeTeam: "충북청주 FC", awayTeam: "김포 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-24"))
        allMatches.append(MockMatch(apiId: 46757, homeTeam: "수원 삼성", awayTeam: "성남 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-30"))
        allMatches.append(MockMatch(apiId: 62871, homeTeam: "서울 이랜드", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 54983, homeTeam: "전남 드래곤즈", awayTeam: "경남 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-30"))
        allMatches.append(MockMatch(apiId: 12367, homeTeam: "부산 아이파크", awayTeam: "천안 시티 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 18088, homeTeam: "부천 FC 1995", awayTeam: "충북청주 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 68391, homeTeam: "충남아산 FC", awayTeam: "김포 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-08-31"))
        allMatches.append(MockMatch(apiId: 48469, homeTeam: "성남 FC", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-07"))
        allMatches.append(MockMatch(apiId: 37325, homeTeam: "경남 FC", awayTeam: "수원 삼성", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-07"))
        allMatches.append(MockMatch(apiId: 43415, homeTeam: "천안 시티 FC", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 86710, homeTeam: "충북청주 FC", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 20202, homeTeam: "김포 FC", awayTeam: "부산 아이파크", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-07"))
        allMatches.append(MockMatch(apiId: 20232, homeTeam: "충남아산 FC", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-06"))
        allMatches.append(MockMatch(apiId: 14512, homeTeam: "인천 유나이티드", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-14"))
        allMatches.append(MockMatch(apiId: 70196, homeTeam: "성남 FC", awayTeam: "경남 FC", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 18083, homeTeam: "수원 삼성", awayTeam: "충북청주 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 38644, homeTeam: "서울 이랜드", awayTeam: "김포 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 20916, homeTeam: "전남 드래곤즈", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-13"))
        allMatches.append(MockMatch(apiId: 25997, homeTeam: "부산 아이파크", awayTeam: "부천 FC 1995", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-14"))
        allMatches.append(MockMatch(apiId: 30170, homeTeam: "경남 FC", awayTeam: "인천 유나이티드", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 76746, homeTeam: "천안 시티 FC", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 80055, homeTeam: "충북청주 FC", awayTeam: "성남 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-20"))
        allMatches.append(MockMatch(apiId: 28235, homeTeam: "충남아산 FC", awayTeam: "수원 삼성", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 65966, homeTeam: "부천 FC 1995", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-20"))
        allMatches.append(MockMatch(apiId: 16715, homeTeam: "부산 아이파크", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-21"))
        allMatches.append(MockMatch(apiId: 40113, homeTeam: "인천 유나이티드", awayTeam: "천안 시티 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 10336, homeTeam: "경남 FC", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 52869, homeTeam: "안산 그리너스", awayTeam: "김포 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-28"))
        allMatches.append(MockMatch(apiId: 28668, homeTeam: "성남 FC", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 50914, homeTeam: "수원 삼성", awayTeam: "부산 아이파크", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 87234, homeTeam: "서울 이랜드", awayTeam: "전남 드래곤즈", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-09-27"))
        allMatches.append(MockMatch(apiId: 61499, homeTeam: "충북청주 FC", awayTeam: "인천 유나이티드", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 74100, homeTeam: "김포 FC", awayTeam: "천안 시티 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 14438, homeTeam: "충남아산 FC", awayTeam: "경남 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 22879, homeTeam: "부천 FC 1995", awayTeam: "안산 그리너스", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 27295, homeTeam: "부산 아이파크", awayTeam: "성남 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-04"))
        allMatches.append(MockMatch(apiId: 57437, homeTeam: "서울 이랜드", awayTeam: "수원 삼성", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-05"))
        allMatches.append(MockMatch(apiId: 60442, homeTeam: "인천 유나이티드", awayTeam: "김포 FC", homeScore: 3, awayScore: 2, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 15406, homeTeam: "충북청주 FC", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 82801, homeTeam: "천안 시티 FC", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 66007, homeTeam: "경남 FC", awayTeam: "부산 아이파크", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 52843, homeTeam: "안산 그리너스", awayTeam: "전남 드래곤즈", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 35904, homeTeam: "성남 FC", awayTeam: "서울 이랜드", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-12"))
        allMatches.append(MockMatch(apiId: 31251, homeTeam: "충남아산 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-18"))
        allMatches.append(MockMatch(apiId: 86214, homeTeam: "부천 FC 1995", awayTeam: "김포 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 78235, homeTeam: "부산 아이파크", awayTeam: "충북청주 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-18"))
        allMatches.append(MockMatch(apiId: 79164, homeTeam: "전남 드래곤즈", awayTeam: "천안 시티 FC", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 31282, homeTeam: "서울 이랜드", awayTeam: "경남 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 69996, homeTeam: "수원 삼성", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-19"))
        allMatches.append(MockMatch(apiId: 44616, homeTeam: "인천 유나이티드", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 82479, homeTeam: "충남아산 FC", awayTeam: "부산 아이파크", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 46097, homeTeam: "김포 FC", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-26"))
        allMatches.append(MockMatch(apiId: 39240, homeTeam: "충북청주 FC", awayTeam: "서울 이랜드", homeScore: 3, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 29458, homeTeam: "천안 시티 FC", awayTeam: "수원 삼성", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 15730, homeTeam: "안산 그리너스", awayTeam: "성남 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-10-25"))
        allMatches.append(MockMatch(apiId: 76471, homeTeam: "부산 아이파크", awayTeam: "인천 유나이티드", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-02"))
        allMatches.append(MockMatch(apiId: 40056, homeTeam: "전남 드래곤즈", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-02"))
        allMatches.append(MockMatch(apiId: 34227, homeTeam: "서울 이랜드", awayTeam: "충남아산 FC", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 82492, homeTeam: "수원 삼성", awayTeam: "김포 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 45520, homeTeam: "성남 FC", awayTeam: "천안 시티 FC", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-02"))
        allMatches.append(MockMatch(apiId: 24177, homeTeam: "안산 그리너스", awayTeam: "경남 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-01"))
        allMatches.append(MockMatch(apiId: 87783, homeTeam: "인천 유나이티드", awayTeam: "전남 드래곤즈", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-08"))
        allMatches.append(MockMatch(apiId: 32492, homeTeam: "부산 아이파크", awayTeam: "서울 이랜드", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 54647, homeTeam: "부천 FC 1995", awayTeam: "수원 삼성", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 41002, homeTeam: "김포 FC", awayTeam: "성남 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 49632, homeTeam: "충북청주 FC", awayTeam: "안산 그리너스", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "충북청주 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 43951, homeTeam: "천안 시티 FC", awayTeam: "경남 FC", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-09"))
        allMatches.append(MockMatch(apiId: 53368, homeTeam: "서울 이랜드", awayTeam: "인천 유나이티드", homeScore: 0, awayScore: 3, status: "FT", time: "종료", stadium: "서울 이랜드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 21401, homeTeam: "수원 삼성", awayTeam: "전남 드래곤즈", homeScore: 1, awayScore: 2, status: "FT", time: "종료", stadium: "수원 삼성 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 39287, homeTeam: "성남 FC", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 3, status: "FT", time: "종료", stadium: "성남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 84213, homeTeam: "안산 그리너스", awayTeam: "충남아산 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "안산 그리너스 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 31075, homeTeam: "경남 FC", awayTeam: "김포 FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "경남 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 33608, homeTeam: "천안 시티 FC", awayTeam: "충북청주 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "천안 시티 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-16"))
        allMatches.append(MockMatch(apiId: 27675, homeTeam: "인천 유나이티드", awayTeam: "수원 삼성", homeScore: 3, awayScore: 3, status: "FT", time: "종료", stadium: "인천 유나이티드 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-22"))
        allMatches.append(MockMatch(apiId: 87941, homeTeam: "전남 드래곤즈", awayTeam: "성남 FC", homeScore: 0, awayScore: 2, status: "FT", time: "종료", stadium: "전남 드래곤즈 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-22"))
        allMatches.append(MockMatch(apiId: 45563, homeTeam: "부산 아이파크", awayTeam: "안산 그리너스", homeScore: 3, awayScore: 0, status: "FT", time: "종료", stadium: "부산 아이파크 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-23"))
        allMatches.append(MockMatch(apiId: 33176, homeTeam: "부천 FC 1995", awayTeam: "경남 FC", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "부천 FC 1995 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-23"))
        allMatches.append(MockMatch(apiId: 44848, homeTeam: "충남아산 FC", awayTeam: "천안 시티 FC", homeScore: 1, awayScore: 3, status: "FT", time: "종료", stadium: "충남아산 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-22"))
        allMatches.append(MockMatch(apiId: 35412, homeTeam: "김포 FC", awayTeam: "충북청주 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "김포 FC 홈경기장", league: 2, dayOffset: 0, dateString: "2025-11-23"))

        // 날짜 차이(dayOffset) 자동 계산 로직
        return allMatches.map { match in
            var updatedMatch = match
            if let dateString = match.dateString, let matchDate = dateFormatter.date(from: dateString) {
                let diff = Calendar.current.dateComponents([.day], from: calendarStartOfDay(today), to: matchDate).day ?? 0
                updatedMatch = MockMatch(apiId: match.apiId, homeTeam: match.homeTeam, awayTeam: match.awayTeam, homeScore: match.homeScore, awayScore: match.awayScore, status: match.status, time: match.time, stadium: match.stadium, league: match.league, dayOffset: diff, dateString: match.dateString)
            }
            return updatedMatch
        }
    }
    
    private static func calendarStartOfDay(_ date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
}
