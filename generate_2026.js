const fs = require('fs');

const k1_teams = ["울산 HD", "포항 스틸러스", "김천 상무", "강원 FC", "FC 서울", "수원 FC", "광주 FC", "제주 유나이티드", "대전 하나 시티즌", "전북 현대", "대구 FC", "인천 유나이티드"];
const k2_teams = ["수원 삼성", "부산 아이파크", "김포 FC", "경남 FC", "부천 FC 1995", "FC 안양", "전남 드래곤즈", "충북청주 FC", "성남 FC", "충남아산 FC", "서울 이랜드", "안산 그리너스", "천안 시티 FC"];

function generateSchedule(teamsArr, startStr, numRounds) {
    let schedule = [];
    let currentDate = new Date(startStr);
    let teams = [...teamsArr];
    let n = teams.length;
    if (n % 2 !== 0) {
        teams.push("BYE");
        n += 1;
    }

    for (let roundNum = 0; roundNum < numRounds; roundNum++) {
        for (let i = 0; i < n / 2; i++) {
            let home = teams[i];
            let away = teams[n - 1 - i];
            if (home === "BYE" || away === "BYE") continue;

            if (roundNum % 2 === 1) {
                let temp = home; home = away; away = temp;
            }

            let dayOffset = Math.random() > 0.5 ? 0 : 1;
            let matchDate = new Date(currentDate);
            matchDate.setDate(matchDate.getDate() + dayOffset);

            let isPast = matchDate < new Date('2026-06-08');
            let status = isPast ? "FT" : "NS";

            let home_score = isPast ? Math.floor(Math.random() * 4) : "nil";
            let away_score = isPast ? Math.floor(Math.random() * 4) : "nil";
            let time_str = isPast ? "종료" : ["14:00", "16:30", "19:00", "19:30"][Math.floor(Math.random() * 4)];

            let isoDate = matchDate.toISOString().split('T')[0];

            schedule.push({
                home, away, home_score, away_score, status, time: time_str, date: isoDate, stadium: `${home} 홈경기장`
            });
        }

        teams.splice(1, 0, teams.pop());

        currentDate.setDate(currentDate.getDate() + 7);
        // 월드컵 휴식기 (6월 11일 ~ 7월 19일)
        if (currentDate.getMonth() === 5 && currentDate.getDate() >= 11) {
            currentDate = new Date('2026-07-25');
        }
    }
    return schedule;
}

const k1_matches = generateSchedule(k1_teams, '2026-03-07', 38);
const k2_matches = generateSchedule(k2_teams, '2026-03-07', 39);

let swiftCode = `import Foundation

struct DummyData2026 {
    static var standings: [Standing] { return DummyData2025.standings }
    static var playerRankings: [PlayerRanking] { return DummyData2025.playerRankings }
    
    static var matches: [MockMatch] {
        var allMatches: [MockMatch] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
`;

function writeMatches(matches, league) {
    matches.forEach(m => {
        let hs = m.home_score;
        let aws = m.away_score;
        let scoreStr = hs !== "nil" ? `homeScore: ${hs}, awayScore: ${aws}` : `homeScore: nil, awayScore: nil`;
        let apiId = Math.floor(Math.random() * 80000) + 10000;
        swiftCode += `        allMatches.append(MockMatch(apiId: ${apiId}, homeTeam: "${m.home}", awayTeam: "${m.away}", ${scoreStr}, status: "${m.status}", time: "${m.time}", stadium: "${m.stadium}", league: ${league}, dayOffset: 0, dateString: "${m.date}"))\n`;
    });
}

writeMatches(k1_matches, 1);
writeMatches(k2_matches, 2);

swiftCode += `
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
`;

fs.writeFileSync('KScout/Services/DummyData2026.swift', swiftCode);
console.log('DummyData2026.swift generated!');
