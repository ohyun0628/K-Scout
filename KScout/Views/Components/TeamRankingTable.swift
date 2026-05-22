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
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 네이버 스포츠 스타일 테이블 헤더
                    HStack(spacing: 0) {
                        Text("순위")
                            .frame(width: 28, alignment: .center)
                        Text("팀명")
                            .frame(width: 105, alignment: .leading)
                            .padding(.leading, 6)
                        Text("승점")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(red: 2/255, green: 114/255, blue: 76/255)) // 네이버 특유의 초록/파란 스탯 강조색
                            .frame(width: 32, alignment: .center)
                        Text("경기")
                            .frame(width: 26, alignment: .center)
                        Text("승")
                            .frame(width: 22, alignment: .center)
                        Text("무")
                            .frame(width: 22, alignment: .center)
                        Text("패")
                            .frame(width: 22, alignment: .center)
                        Text("득실")
                            .frame(width: 28, alignment: .center)
                        Text("최근 5경기")
                            .frame(width: 95, alignment: .center)
                            .padding(.leading, 10)
                    }
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.5))
                    
                    Divider()
                    
                    // 팀 로우 목록
                    ForEach(teams) { team in
                        teamRow(team)
                        if team.id != teams.last?.id {
                            Divider()
                        }
                    }
                }
                .frame(width: 381) // 전체 컬럼 가로폭 고정으로 줄맞춤 보장
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
        }
    }
    
    @ViewBuilder
    private func teamRow(_ team: Standing) -> some View {
        NavigationLink(destination: TeamDetailView(standing: team, season: season)) {
            HStack(spacing: 0) {
                // 1. 순위
                Text("\(team.rank)")
                    .font(.system(size: 13, weight: team.rank <= 3 ? .bold : .medium))
                    .foregroundColor(team.rank <= 3 ? Color.brandNavy : .gray)
                    .frame(width: 28, alignment: .center)
                
                // 2. 팀명 (엠블럼 + 텍스트 + 이동 기호 '>')
                HStack(spacing: 5) {
                    TeamLogoView(teamName: team.teamName, size: 20)
                    
                    Text(team.teamName)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.gray.opacity(0.4))
                }
                .frame(width: 105, alignment: .leading)
                .padding(.leading, 6)
                
                // 3. 승점 (강조 색상 및 굵게 표시)
                Text("\(team.points)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 112/255, blue: 183/255))
                    .frame(width: 32, alignment: .center)
                
                // 4. 경기수
                Text("\(team.played)")
                    .font(.system(size: 13))
                    .foregroundColor(.primary)
                    .frame(width: 26, alignment: .center)
                
                // 5. 승
                Text("\(team.won)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .frame(width: 22, alignment: .center)
                
                // 6. 무
                Text("\(team.draw)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .frame(width: 22, alignment: .center)
                
                // 7. 패
                Text("\(team.lost)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .frame(width: 22, alignment: .center)
                
                // 8. 득실차
                Text("\(team.goalsDiff > 0 ? "+" : "")\(team.goalsDiff)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(team.goalsDiff > 0 ? Color.red : (team.goalsDiff < 0 ? Color.blue : .primary))
                    .frame(width: 28, alignment: .center)
                
                // 9. 최근 5경기 폼 뱃지
                recentFormView(form: team.form)
            }
            .padding(.vertical, 12)
            .background(Color.white)
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
    
    // 네이버 스포츠 톤 매치 (승: 초록 계열 / 무: 회색 계열 / 패: 파란 계열)
    private func formTextColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 2/255, green: 114/255, blue: 76/255)
        case "D", "d": return Color(red: 102/255, green: 102/255, blue: 102/255)
        case "L", "l": return Color(red: 21/255, green: 112/255, blue: 183/255)
        default: return Color.gray
        }
    }
    
    private func formBackgroundColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 224/255, green: 245/255, blue: 233/255)
        case "D", "d": return Color(red: 242/255, green: 242/255, blue: 242/255)
        case "L", "l": return Color(red: 230/255, green: 242/255, blue: 250/255)
        default: return Color.clear
        }
    }
    
    private func formBorderColor(for char: Character) -> Color {
        switch char {
        case "W", "w": return Color(red: 136/255, green: 218/255, blue: 181/255)
        case "D", "d": return Color(red: 217/255, green: 217/255, blue: 217/255)
        case "L", "l": return Color(red: 163/255, green: 204/255, blue: 235/255)
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
