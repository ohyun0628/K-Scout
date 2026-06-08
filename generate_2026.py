import json
import datetime
import random

k1_teams = ["울산 HD", "포항 스틸러스", "김천 상무", "강원 FC", "FC 서울", "수원 FC", "광주 FC", "제주 유나이티드", "대전 하나 시티즌", "전북 현대", "대구 FC", "인천 유나이티드"]
k2_teams = ["수원 삼성", "부산 아이파크", "김포 FC", "경남 FC", "부천 FC 1995", "FC 안양", "전남 드래곤즈", "충북청주 FC", "성남 FC", "충남아산 FC", "서울 이랜드", "안산 그리너스", "천안 시티 FC"]

# Generate full round-robin schedules for K1 and K2
def generate_schedule(teams, start_date, num_rounds):
    schedule = []
    current_date = start_date
    n = len(teams)
    is_odd = (n % 2 != 0)
    if is_odd:
        teams.append("BYE")
        n += 1
    
    match_id = 1000
    for round_num in range(num_rounds):
        # Every round is a weekend
        # Distribute matches over Saturday and Sunday
        for i in range(n // 2):
            home = teams[i]
            away = teams[n - 1 - i]
            if home == "BYE" or away == "BYE":
                continue
            
            # Swap home and away for half the rounds to balance
            if round_num % 2 == 1:
                home, away = away, home
                
            day_offset = random.choice([0, 1]) # 0 for Saturday, 1 for Sunday
            match_date = current_date + datetime.timedelta(days=day_offset)
            
            is_past = match_date < datetime.date(2026, 6, 8)
            status = "FT" if is_past else "NS"
            
            if is_past:
                home_score = random.randint(0, 3)
                away_score = random.randint(0, 3)
                time_str = "종료"
            else:
                home_score = "nil"
                away_score = "nil"
                time_str = random.choice(["14:00", "16:30", "19:00", "19:30"])
                
            schedule.append({
                "home": home,
                "away": away,
                "home_score": home_score,
                "away_score": away_score,
                "status": status,
                "time": time_str,
                "date": match_date.strftime("%Y-%m-%d"),
                "stadium": f"{home} 홈경기장"
            })
        
        # Round Robin rotation
        teams.insert(1, teams.pop())
        
        # Advance date by 1 week, except for June (World Cup break)
        current_date += datetime.timedelta(days=7)
        if current_date.month == 6 and current_date.day >= 11:
            current_date = datetime.date(2026, 7, 25) # Skip to late July
            
    return schedule

k1_matches = generate_schedule(k1_teams.copy(), datetime.date(2026, 3, 7), 38)
k2_matches = generate_schedule(k2_teams.copy(), datetime.date(2026, 3, 7), 39)

swift_code = """import Foundation

struct DummyData2026 {
    static var standings: [Standing] {
        return DummyData2025.standings
    }
    
    static var playerRankings: [PlayerRanking] {
        return DummyData2025.playerRankings
    }
    
    static var matches: [MockMatch] {
        var allMatches: [MockMatch] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        
"""

for m in k1_matches:
    hs = m['home_score']
    aws = m['away_score']
    score_str = f"homeScore: {hs}, awayScore: {aws}" if hs != "nil" else "homeScore: nil, awayScore: nil"
    swift_code += f"""        allMatches.append(MockMatch(apiId: {random.randint(10000, 90000)}, homeTeam: "{m['home']}", awayTeam: "{m['away']}", {score_str}, status: "{m['status']}", time: "{m['time']}", stadium: "{m['stadium']}", league: 1, dayOffset: 0, dateString: "{m['date']}"))\n"""

for m in k2_matches:
    hs = m['home_score']
    aws = m['away_score']
    score_str = f"homeScore: {hs}, awayScore: {aws}" if hs != "nil" else "homeScore: nil, awayScore: nil"
    swift_code += f"""        allMatches.append(MockMatch(apiId: {random.randint(10000, 90000)}, homeTeam: "{m['home']}", awayTeam: "{m['away']}", {score_str}, status: "{m['status']}", time: "{m['time']}", stadium: "{m['stadium']}", league: 2, dayOffset: 0, dateString: "{m['date']}"))\n"""

swift_code += """
        // Recalculate dayOffset based on today
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
"""

with open("KScout/Services/DummyData2026.swift", "w", encoding="utf-8") as f:
    f.write(swift_code)
print("DummyData2026.swift generated.")
