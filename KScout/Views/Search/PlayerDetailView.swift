import SwiftUI

struct PlayerDetailView: View {
    let player: Player
    let season: Int
    @ObservedObject private var favoriteManager = FavoriteManager.shared
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // 선수 기본 인포 카드
                    VStack(spacing: 12) {
                        // 선수 프로필 이미지 (실사 사진 또는 이니셜 원형 배지)
                        if let photoUrl = player.photo, !photoUrl.isEmpty {
                            RemoteImageView(urlString: photoUrl, size: 80, fallback: AnyView(fallbackAvatar), isCircle: true)
                                .overlay(
                                    Circle()
                                        .stroke(logoColor(for: player.teamName), lineWidth: 3)
                                )
                        } else {
                            fallbackAvatar
                        }
                        
                        VStack(spacing: 4) {
                            Text(player.name)
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primary)
                            
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(logoColor(for: player.teamName))
                                    .frame(width: 10, height: 10)
                                
                                Text(player.teamName)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.02), radius: 8, x: 0, y: 4)
                    
                    // 레이더 차트 분석 카드
                    VStack(spacing: 16) {
                        Text("상세 차트")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.brandNavy)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        RadarChartView(data: player.radarData)
                            .frame(height: 220)
                            .padding(.vertical, 8)
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.02), radius: 8, x: 0, y: 4)
                    
                    // 상세 스탯 정보 리스트 카드
                    VStack(spacing: 0) {
                        let leagueName = player.leagueName ?? "K리그"
                        Text("\(leagueName) 통합 상세 기록")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.brandNavy)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 18)
                            .padding(.bottom, 12)
                        
                        Divider()
                        
                        VStack(spacing: 0) {
                            statRow(title: "득점 (Goals)", value: "\(player.goals)골", color: .red)
                            Divider().padding(.leading, 20)
                            statRow(title: "도움 (Assists)", value: "\(player.assists)도움", color: .blue)
                            Divider().padding(.leading, 20)
                            statRow(title: "슈팅 (Shots)", value: "\(player.shots)회", color: .orange)
                            Divider().padding(.leading, 20)
                            statRow(title: "패스 (Passes)", value: "\(player.passes)회", color: .green)
                            Divider().padding(.leading, 20)
                            statRow(title: "수비 성공 (Defense)", value: "\(player.defense)회", color: .purple)
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.02), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("선수 상세 분석")
        .navigationBarItems(
            trailing: Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                favoriteManager.toggleFavorite(playerID: player.id, season: season)
            }) {
                Image(systemName: favoriteManager.isFavorite(playerID: player.id) ? "star.fill" : "star")
                    .font(.title3)
                    .foregroundColor(favoriteManager.isFavorite(playerID: player.id) ? .yellow : .gray)
            }
        )
    }
    
    @ViewBuilder
    private func statRow(title: String, value: String, color: Color) -> some View {
        HStack {
            HStack(spacing: 10) {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 8, height: 8)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
            }
            Spacer()
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.brandNavy)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
    
    private var fallbackAvatar: some View {
        Circle()
            .fill(logoColor(for: player.teamName).opacity(0.1))
            .frame(width: 80, height: 80)
            .overlay(
                Circle()
                    .stroke(logoColor(for: player.teamName), lineWidth: 3)
            )
            .overlay(
                Text(String(player.name.prefix(1)))
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(logoColor(for: player.teamName))
            )
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

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayerDetailView(player: Player(id: 1, name: "주민규", photo: nil, teamName: "울산 HD", leagueName: nil, goals: 14, assists: 3, shots: 48, passes: 320, defense: 12), season: 2024)
        }
    }
}
