import SwiftUI

struct PlayerStatsGridView: View {
    let rankings: [PlayerRanking]
    @Binding var selectedStatType: String
    var onRowTapped: ((Int) -> Void)? = nil
    
    struct StatColumn: Identifiable {
        var id: String { type }
        let title: String
        let type: String
        let width: CGFloat
    }
    
    // 열 구조 정의
    private let columns: [StatColumn] = [
        StatColumn(title: "득점", type: "goals", width: 55),
        StatColumn(title: "도움", type: "assists", width: 55),
        StatColumn(title: "공격포인트", type: "points", width: 85),
        StatColumn(title: "PK골", type: "pkGoals", width: 55),
        StatColumn(title: "경기", type: "played", width: 55),
        StatColumn(title: "MOM", type: "mom", width: 55),
        StatColumn(title: "평균평점", type: "rating", width: 70),
        StatColumn(title: "BEST11", type: "best11", width: 70),
        StatColumn(title: "슈팅", type: "shots", width: 55),
        StatColumn(title: "유효슈팅", type: "shotsOnTarget", width: 70),
        StatColumn(title: "출전시간(분)", type: "minutes", width: 95),
        StatColumn(title: "파울", type: "fouls", width: 55),
        StatColumn(title: "경고", type: "yellowCards", width: 55)
    ]
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            leftColumn
            
            // 고정 컬럼과 스크롤 영역 구분선
            Rectangle()
                .fill(Color(UIColor.separator).opacity(0.8))
                .frame(width: 1)
            
            rightScrollableGrid
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(UIColor.separator).opacity(0.5), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private var leftColumn: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 헤더 셀
            Text("순위 / 선수")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.gray)
                .frame(width: 165, height: 44, alignment: .leading)
                .padding(.leading, 12)
                .background(Color(UIColor.secondarySystemBackground).opacity(0.4))
            
            Divider()
            
            // 데이터 셀 반복
            ForEach(rankings) { player in
                HStack(spacing: 8) {
                    // 순위
                    ZStack {
                        if player.rank <= 3 {
                            Circle()
                                .fill(rankBadgeColor(for: player.rank))
                                .frame(width: 22, height: 22)
                            
                            Text("\(player.rank)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        } else {
                            Text("\(player.rank)")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 24)
                    
                    // 실사 프로필 사진 추가
                    PlayerAvatarView(playerName: player.playerName, teamName: player.teamName, photoURL: player.photoURL, size: 28)
                    
                    // 이름 & 팀
                    VStack(alignment: .leading, spacing: 2) {
                        Text(player.playerName)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        
                        HStack(spacing: 4) {
                            TeamLogoView(teamName: player.teamName, size: 10)
                            
                            Text(player.teamName)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                }
                .frame(width: 165, height: 52, alignment: .leading)
                .padding(.leading, 12)
                .background(Color.white)
                .contentShape(Rectangle())
                .onTapGesture {
                    if let action = onRowTapped {
                        action(player.id)
                    }
                }
                
                if player.id != rankings.last?.id {
                    Divider()
                }
            }
        }
        .frame(width: 165)
    }
    
    @ViewBuilder
    private var rightScrollableGrid: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                // 스탯 헤더 행
                HStack(spacing: 0) {
                    ForEach(columns) { col in
                        Button(action: {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                selectedStatType = col.type
                            }
                        }) {
                            HStack(spacing: 3) {
                                Text(col.title)
                                    .font(.system(size: 12, weight: selectedStatType == col.type ? .bold : .semibold))
                                    .foregroundColor(selectedStatType == col.type ? Color.brandNavy : .gray)
                                
                                if selectedStatType == col.type {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 8, weight: .bold))
                                        .foregroundColor(Color.brandNavy)
                                }
                            }
                            .frame(width: col.width, height: 44, alignment: .center)
                            .background(selectedStatType == col.type ? Color.brandNavy.opacity(0.06) : Color.clear)
                        }
                    }
                }
                .background(Color(UIColor.secondarySystemBackground).opacity(0.4))
                
                Divider()
                
                // 스탯 데이터 행 반복
                ForEach(rankings) { player in
                    HStack(spacing: 0) {
                        ForEach(columns) { col in
                            Text(getStatValueString(for: player, type: col.type))
                                .font(.system(size: 13, weight: selectedStatType == col.type ? .bold : .regular))
                                .foregroundColor(selectedStatType == col.type ? Color.brandNavy : .primary)
                                .frame(width: col.width, height: 52, alignment: .center)
                                .background(selectedStatType == col.type ? Color.brandNavy.opacity(0.03) : Color.clear)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if let action = onRowTapped {
                            action(player.id)
                        }
                    }
                    
                    if player.id != rankings.last?.id {
                        Divider()
                    }
                }
            }
        }
    }
    
    // MARK: - 스탯 타입별 표시 문자열 포맷
    private func getStatValueString(for player: PlayerRanking, type: String) -> String {
        switch type {
        case "goals":
            return "\(player.goals)"
        case "assists":
            return "\(player.assists)"
        case "points":
            return "\(player.attackPoints)"
        case "pkGoals":
            return "\(player.pkGoals)"
        case "played":
            return "\(player.played)"
        case "mom":
            return "\(player.momCount)"
        case "rating":
            return String(format: "%.2f", player.avgRating)
        case "best11":
            return "\(player.best11Count)"
        case "shots":
            return "\(player.shots)"
        case "shotsOnTarget":
            return "\(player.shotsOnTarget)"
        case "minutes":
            return String(format: "%d", player.playedMinutes)
        case "fouls":
            return "\(player.fouls)"
        case "yellowCards":
            return "\(player.yellowCards)"
        default:
            return ""
        }
    }
    
    // MARK: - 순위 메달/뱃지 색상 매핑
    private func rankBadgeColor(for rank: Int) -> Color {
        switch rank {
        case 1:
            return Color(red: 0.95, green: 0.75, blue: 0.0) // 금색
        case 2:
            return Color(red: 0.75, green: 0.75, blue: 0.75) // 은색
        case 3:
            return Color(red: 0.8, green: 0.55, blue: 0.35) // 동색
        default:
            return Color.gray
        }
    }
    
    // MARK: - 팀 로고 배지 컬러 매핑
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
