import SwiftUI

struct PlayerRankingRow: View {
    let player: PlayerRanking
    
    var body: some View {
        HStack(spacing: 0) {
            // 순위 표시
            ZStack {
                if player.rank <= 3 {
                    Circle()
                        .fill(rankBadgeColor(for: player.rank))
                        .frame(width: 26, height: 26)
                    
                    Text("\(player.rank)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Text("\(player.rank)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 36, alignment: .center)
            
            // 실사 프로필 사진 추가
            PlayerAvatarView(playerName: player.playerName, teamName: player.teamName, photoURL: player.photoURL, size: 36)
                .padding(.leading, 8)
            
            // 선수 프로필 (소속 팀 로고 배지 및 이름/팀명)
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(player.playerName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 6) {
                    TeamLogoView(teamName: player.teamName, size: 12)
                    
                    Text(player.teamName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 출장 경기 수 및 스탯 개수
            HStack(spacing: 12) {
                Text("\(player.played)경기")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray.opacity(0.8))
                
                Text(statString(for: player))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.brandNavy)
                    .frame(width: 75, alignment: .trailing)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
    }
    
    private func statString(for player: PlayerRanking) -> String {
        switch player.type {
        case "goals":
            return "\(player.goals)골"
        case "assists":
            return "\(player.assists)도움"
        case "points":
            return "\(player.attackPoints)P"
        case "mom":
            return "\(player.momCount)회"
        case "rating":
            return String(format: "%.2f점", player.avgRating)
        case "best11":
            return "\(player.best11Count)회"
        case "goalsPer90":
            return String(format: "%.2f골", player.goalsPer90)
        case "pointsPer90":
            return String(format: "%.2fP", player.pointsPer90)
        case "shots":
            return "\(player.shots)슈팅"
        case "shotsOnTarget":
            return "\(player.shotsOnTarget)유효"
        case "minutes":
            return "\(player.playedMinutes)분"
        default:
            return "\(player.statCount)"
        }
    }
    
    private func rankBadgeColor(for rank: Int) -> Color {
        switch rank {
        case 1:
            return Color(red: 0.9, green: 0.7, blue: 0.0) // 금색
        case 2:
            return Color(red: 0.7, green: 0.7, blue: 0.7) // 은색
        case 3:
            return Color(red: 0.8, green: 0.5, blue: 0.3) // 동색
        default:
            return Color.gray
        }
    }
    
    // K리그 실전 매칭을 위한 팀별 브랜드 컬러 매핑 함수 (동일 로직 유지)
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

struct PlayerRankingRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerRankingRow(player: PlayerRanking(id: 1, rank: 1, playerName: "주민규", teamName: "울산 HD", statCount: 14, played: 16, league: 1, type: "goals"))
                .previewLayout(.sizeThatFits)
            PlayerRankingRow(player: PlayerRanking(id: 2, rank: 4, playerName: "송민규", teamName: "전북 현대", statCount: 8, played: 14, league: 1, type: "goals"))
                .previewLayout(.sizeThatFits)
        }
    }
}
