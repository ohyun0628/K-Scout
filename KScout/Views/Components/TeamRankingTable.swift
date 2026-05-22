import SwiftUI

struct TeamRankingTable: View {
    let standings: [Standing]
    let season: Int
    
    var body: some View {
        if standings.isEmpty {
            VStack {
                Spacer()
                Text("순위 데이터가 없습니다.")
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(minHeight: 300)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
        } else {
            let hasSplit = standings.contains { $0.group == "Championship Round" || $0.group == "Relegation Round" }
            
            VStack(spacing: 24) {
                if hasSplit {
                    let groupA = standings.filter { $0.group == "Championship Round" }.sorted { $0.rank < $1.rank }
                    let groupB = standings.filter { $0.group == "Relegation Round" }.sorted { $0.rank < $1.rank }
                    
                    if !groupA.isEmpty {
                        groupSection(title: "파이널 그룹 A조", teams: groupA)
                    }
                    if !groupB.isEmpty {
                        groupSection(title: "파이널 그룹 B조", teams: groupB)
                    }
                } else {
                    groupSection(title: nil, teams: standings.sorted { $0.rank < $1.rank })
                }
            }
        }
    }
    
    @ViewBuilder
    private func groupSection(title: String?, teams: [Standing]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title = title {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.brandNavy)
                    .padding(.horizontal, 4)
            }
            
            VStack(spacing: 0) {
                // 테이블 헤더
                HStack(spacing: 0) {
                    Text("순위")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(width: 32, alignment: .center)
                    
                    Text("팀")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    HStack(spacing: 0) {
                        Text("경")
                            .frame(width: 24, alignment: .center)
                        Text("승")
                            .frame(width: 24, alignment: .center)
                        Text("무")
                            .frame(width: 24, alignment: .center)
                        Text("패")
                            .frame(width: 24, alignment: .center)
                        Text("승점")
                            .font(.system(size: 12, weight: .bold))
                            .frame(width: 38, alignment: .trailing)
                        
                        Text("최근 5경기")
                            .font(.system(size: 12, weight: .bold))
                            .frame(width: 95, alignment: .center)
                            .padding(.leading, 10)
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white)
                
                Divider()
                
                // 팀 로우들
                ForEach(teams) { team in
                    teamRow(team)
                    if team.id != teams.last?.id {
                        Divider()
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
        }
    }
    
    @ViewBuilder
    private func teamRow(_ team: Standing) -> some View {
        NavigationLink(destination: TeamDetailView(standing: team, season: season)) {
            HStack(spacing: 0) {
                // 순위 숫자 (1,2,3위는 굵고 선명하게 강조)
                Text("\(team.rank)")
                    .font(.system(size: 14, weight: team.rank <= 3 ? .black : .medium))
                    .foregroundColor(team.rank <= 3 ? Color.brandNavy : .gray)
                    .frame(width: 32, alignment: .center)
                
                // 팀 로고 뱃지 및 팀명
                HStack(spacing: 8) {
                    Circle()
                        .fill(logoColor(for: team.teamName))
                        .frame(width: 24, height: 24)
                        .overlay(
                            Text(String(team.teamName.prefix(1)))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    Text(team.teamName)
                        .font(.system(size: 13, weight: team.rank <= 3 ? .bold : .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
                
                // 경기 통계 기록들 및 최근 5경기 뱃지
                HStack(spacing: 0) {
                    Text("\(team.played)")
                        .foregroundColor(.gray)
                        .frame(width: 24, alignment: .center)
                    Text("\(team.won)")
                        .foregroundColor(.gray)
                        .frame(width: 24, alignment: .center)
                    Text("\(team.draw)")
                        .foregroundColor(.gray)
                        .frame(width: 24, alignment: .center)
                    Text("\(team.lost)")
                        .foregroundColor(.gray)
                        .frame(width: 24, alignment: .center)
                    Text("\(team.points)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color.brandNavy)
                        .frame(width: 38, alignment: .trailing)
                    
                    // 최근 5경기 승무패 뱃지
                    recentFormView(form: team.form)
                }
                .font(.system(size: 13, weight: .medium))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(team.rank <= 3 ? Color.brandNavy.opacity(0.02) : Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private func recentFormView(form: String?) -> some View {
        HStack(spacing: 3) {
            if let form = form, !form.isEmpty {
                let formChars = Array(form.suffix(5))
                ForEach(0..<formChars.count, id: \.self) { index in
                    let char = formChars[index]
                    Text(formText(for: char))
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(formTextColor(for: char))
                        .frame(width: 15, height: 15)
                        .background(formBackgroundColor(for: char))
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(formBorderColor(for: char), lineWidth: 0.5)
                        )
                }
            } else {
                Text("-")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 95, alignment: .center)
        .padding(.leading, 10)
    }
    
    private func formText(for char: Character) -> String {
        switch char {
        case "W", "w": return "승"
        case "D", "d": return "무"
        case "L", "l": return "패"
        default: return String(char)
        }
    }
    
    private func formTextColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 0.08, green: 0.55, blue: 0.35)
        case "D", "d": return Color.gray
        case "L", "l": return Color(red: 0.75, green: 0.15, blue: 0.15)
        default: return Color.gray
        }
    }
    
    private func formBackgroundColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 0.08, green: 0.55, blue: 0.35).opacity(0.1)
        case "D", "d": return Color.gray.opacity(0.1)
        case "L", "l": return Color(red: 0.75, green: 0.15, blue: 0.15).opacity(0.1)
        default: return Color.clear
        }
    }
    
    private func formBorderColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 0.08, green: 0.55, blue: 0.35).opacity(0.3)
        case "D", "d": return Color.gray.opacity(0.3)
        case "L", "l": return Color(red: 0.75, green: 0.15, blue: 0.15).opacity(0.3)
        default: return Color.clear
        }
    }
    
    private func logoColor(for teamName: String) -> Color {
        if teamName.contains("울산") {
            return Color(red: 0.0, green: 0.2, blue: 0.6)
        } else if teamName.contains("전북") {
            return Color(red: 0.1, green: 0.6, blue: 0.1)
        } else if teamName.contains("포항") {
            return Color(red: 0.1, green: 0.1, blue: 0.1)
        } else if teamName.contains("수원 FC") {
            return Color(red: 0.05, green: 0.15, blue: 0.35)
        } else if teamName.contains("수원 삼성") {
            return Color(red: 0.0, green: 0.3, blue: 0.8)
        } else if teamName.contains("서울") {
            return Color(red: 0.8, green: 0.1, blue: 0.1)
        } else if teamName.contains("대전") {
            return Color(red: 0.0, green: 0.35, blue: 0.25)
        } else if teamName.contains("강원") {
            return Color(red: 0.95, green: 0.5, blue: 0.1)
        } else if teamName.contains("광주") {
            return Color(red: 0.9, green: 0.7, blue: 0.0)
        } else if teamName.contains("대구") {
            return Color(red: 0.35, green: 0.65, blue: 0.85)
        } else if teamName.contains("인천") {
            return Color(red: 0.0, green: 0.25, blue: 0.5)
        } else if teamName.contains("제주") {
            return Color(red: 0.9, green: 0.35, blue: 0.0)
        } else if teamName.contains("김천") {
            return Color(red: 0.75, green: 0.1, blue: 0.15)
        } else if teamName.contains("부산") {
            return Color(red: 0.8, green: 0.05, blue: 0.05)
        } else if teamName.contains("전남") {
            return Color(red: 0.95, green: 0.75, blue: 0.0)
        } else if teamName.contains("성남") {
            return Color(red: 0.15, green: 0.15, blue: 0.15)
        } else if teamName.contains("안양") {
            return Color(red: 0.35, green: 0.15, blue: 0.55)
        } else if teamName.contains("부천") {
            return Color(red: 0.8, green: 0.0, blue: 0.1)
        } else if teamName.contains("충남아산") {
            return Color(red: 0.0, green: 0.45, blue: 0.75)
        }
        return Color.brandNavy
    }
}

struct TeamRankingTable_Previews: PreviewProvider {
    static var previews: some View {
        TeamRankingTable(standings: [
            Standing(id: 1, rank: 1, teamName: "울산 HD FC", points: 33, goalsDiff: 15, played: 15, won: 10, draw: 3, lost: 2, league: 1, group: "Championship Round", form: "WWDLW"),
            Standing(id: 2, rank: 2, teamName: "전북 현대", points: 31, goalsDiff: 12, played: 15, won: 9, draw: 4, lost: 2, league: 1, group: "Championship Round", form: "WDWWL")
        ], season: 2025)
    }
}
