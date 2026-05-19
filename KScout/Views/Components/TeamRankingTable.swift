import SwiftUI

struct TeamRankingTable: View {
    let standings: [Standing]
    
    var body: some View {
        VStack(spacing: 0) {
            // 테이블 헤더
            HStack(spacing: 0) {
                Text("순위")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(width: 40, alignment: .center)
                
                Text("팀")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                
                HStack(spacing: 0) {
                    Text("경")
                        .frame(width: 32, alignment: .center)
                    Text("승")
                        .frame(width: 32, alignment: .center)
                    Text("무")
                        .frame(width: 32, alignment: .center)
                    Text("패")
                        .frame(width: 32, alignment: .center)
                    Text("승점")
                        .font(.system(size: 13, weight: .bold))
                        .frame(width: 45, alignment: .trailing)
                }
                .font(.system(size: 13))
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            Divider()
            
            // 테이블 바디
            if standings.isEmpty {
                VStack {
                    Spacer()
                    Text("순위 데이터가 없습니다.")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(minHeight: 300)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(standings) { team in
                            teamRow(team)
                            Divider()
                        }
                    }
                }
                .background(Color.white)
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
    }
    
    @ViewBuilder
    private func teamRow(_ team: Standing) -> some View {
        HStack(spacing: 0) {
            // 순위 숫자 (1,2,3위는 굵고 선명하게 강조)
            Text("\(team.rank)")
                .font(.system(size: 16, weight: team.rank <= 3 ? .black : .medium))
                .foregroundColor(team.rank <= 3 ? Color.brandNavy : .gray)
                .frame(width: 40, alignment: .center)
            
            // 팀 로고 뱃지 및 팀명
            HStack(spacing: 10) {
                Circle()
                    .fill(logoColor(for: team.teamName))
                    .frame(width: 28, height: 28)
                    .overlay(
                        Text(String(team.teamName.prefix(1)))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                Text(team.teamName)
                    .font(.system(size: 15, weight: team.rank <= 3 ? .bold : .semibold))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 12)
            
            // 경기 통계 기록들
            HStack(spacing: 0) {
                Text("\(team.played)")
                    .foregroundColor(.gray)
                    .frame(width: 32, alignment: .center)
                Text("\(team.won)")
                    .foregroundColor(.gray)
                    .frame(width: 32, alignment: .center)
                Text("\(team.draw)")
                    .foregroundColor(.gray)
                    .frame(width: 32, alignment: .center)
                Text("\(team.lost)")
                    .foregroundColor(.gray)
                    .frame(width: 32, alignment: .center)
                Text("\(team.points)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.brandNavy)
                    .frame(width: 45, alignment: .trailing)
            }
            .font(.system(size: 14, weight: .medium))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(team.rank <= 3 ? Color.brandNavy.opacity(0.02) : Color.clear)
    }
    
    // K리그 실전 매칭을 위한 팀별 브랜드 컬러 매핑 함수
    private func logoColor(for teamName: String) -> Color {
        if teamName.contains("울산") {
            return Color(red: 0.0, green: 0.2, blue: 0.6) // 울산 블루
        } else if teamName.contains("전북") {
            return Color(red: 0.1, green: 0.6, blue: 0.1) // 전북 그린
        } else if teamName.contains("포항") {
            return Color(red: 0.1, green: 0.1, blue: 0.1) // 포항 블랙
        } else if teamName.contains("수원 FC") {
            return Color(red: 0.05, green: 0.15, blue: 0.35) // 수원FC 네이비
        } else if teamName.contains("수원 삼성") {
            return Color(red: 0.0, green: 0.3, blue: 0.8) // 수원 블루
        } else if teamName.contains("서울") {
            return Color(red: 0.8, green: 0.1, blue: 0.1) // 서울 레드
        } else if teamName.contains("대전") {
            return Color(red: 0.0, green: 0.35, blue: 0.25) // 대전 초록
        } else if teamName.contains("강원") {
            return Color(red: 0.95, green: 0.5, blue: 0.1) // 강원 오렌지
        } else if teamName.contains("광주") {
            return Color(red: 0.9, green: 0.7, blue: 0.0) // 광주 옐로우
        } else if teamName.contains("대구") {
            return Color(red: 0.35, green: 0.65, blue: 0.85) // 대구 스카이블루
        } else if teamName.contains("인천") {
            return Color(red: 0.0, green: 0.25, blue: 0.5) // 인천 블루
        } else if teamName.contains("제주") {
            return Color(red: 0.9, green: 0.35, blue: 0.0) // 제주 주황
        } else if teamName.contains("김천") {
            return Color(red: 0.75, green: 0.1, blue: 0.15) // 김천 레드
        } else if teamName.contains("부산") {
            return Color(red: 0.8, green: 0.05, blue: 0.05) // 부산 레드
        } else if teamName.contains("전남") {
            return Color(red: 0.95, green: 0.75, blue: 0.0) // 전남 노랑
        } else if teamName.contains("성남") {
            return Color(red: 0.15, green: 0.15, blue: 0.15) // 성남 블랙
        } else if teamName.contains("안양") {
            return Color(red: 0.35, green: 0.15, blue: 0.55) // 안양 보라
        } else if teamName.contains("부천") {
            return Color(red: 0.8, green: 0.0, blue: 0.1) // 부천 레드
        } else if teamName.contains("충남아산") {
            return Color(red: 0.0, green: 0.45, blue: 0.75) // 아산 블루
        }
        return Color.brandNavy // 기본값
    }
}

struct TeamRankingTable_Previews: PreviewProvider {
    static var previews: some View {
        TeamRankingTable(standings: [
            Standing(id: 1, rank: 1, teamName: "울산 HD", points: 33, goalsDiff: 15, played: 15, won: 10, draw: 3, lost: 2, league: 1),
            Standing(id: 2, rank: 2, teamName: "전북 현대", points: 31, goalsDiff: 12, played: 15, won: 9, draw: 4, lost: 2, league: 1)
        ])
    }
}
