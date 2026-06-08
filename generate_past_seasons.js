const fs = require('fs');

const k1_teams = ["울산 HD", "포항 스틸러스", "김천 상무", "강원 FC", "FC 서울", "수원 FC", "광주 FC", "제주 유나이티드", "대전 하나 시티즌", "전북 현대", "대구 FC", "FC 안양"];
const k2_teams = ["인천 유나이티드", "수원 삼성", "서울 이랜드", "전남 드래곤즈", "부산 아이파크", "부천 FC 1995", "충남아산 FC", "김포 FC", "충북청주 FC", "천안 시티 FC", "경남 FC", "안산 그리너스", "성남 FC"];

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

            let status = "FT"; // All past seasons are FT
            let home_score = Math.floor(Math.random() * 4);
            let away_score = Math.floor(Math.random() * 4);
            let time_str = "종료";
            let isoDate = matchDate.toISOString().split('T')[0];

            schedule.push({
                home, away, home_score, away_score, status, time: time_str, date: isoDate, stadium: `${home} 홈경기장`
            });
        }

        teams.splice(1, 0, teams.pop());
        currentDate.setDate(currentDate.getDate() + 7);
    }
    return schedule;
}

function generateSwiftForYear(year) {
    const k1_matches = generateSchedule(k1_teams, `${year}-03-01`, 38);
    const k2_matches = generateSchedule(k2_teams, `${year}-03-01`, 39);

    let swiftCode = `import Foundation

struct DummyData${year} {
    static var standings: [Standing] { return DummyData2025.standings }
    static var playerRankings: [PlayerRanking] { return DummyData2025.playerRankings }
    
    static var matches: [MockMatch] {
        var allMatches: [MockMatch] = []
`;

    function writeMatches(matches, league) {
        matches.forEach(m => {
            let apiId = Math.floor(Math.random() * 80000) + 10000;
            swiftCode += `        allMatches.append(MockMatch(apiId: ${apiId}, homeTeam: "${m.home}", awayTeam: "${m.away}", homeScore: ${m.home_score}, awayScore: ${m.away_score}, status: "${m.status}", time: "${m.time}", stadium: "${m.stadium}", league: ${league}, dayOffset: 0, dateString: "${m.date}"))\n`;
        });
    }

    writeMatches(k1_matches, 1);
    writeMatches(k2_matches, 2);

    swiftCode += `        return allMatches\n    }\n}\n`;

    fs.writeFileSync(`KScout/Services/DummyData${year}.swift`, swiftCode);
    console.log(`DummyData${year}.swift generated.`);
}

[2022, 2023, 2024].forEach(generateSwiftForYear);
