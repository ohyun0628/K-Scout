import SwiftUI

struct FavoriteView: View {
    @ObservedObject private var favoriteManager = FavoriteManager.shared
    
    let showBackButton: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(showBackButton: Bool = false) {
        self.showBackButton = showBackButton
    }
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 공통 상단 헤더 타이틀
                HeaderTitleView(title: "관심 선수", showBackButton: showBackButton) {
                    presentationMode.wrappedValue.dismiss()
                }
                
                if favoriteManager.favoritePlayers.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Text("즐겨찾기한 선수가 없습니다.")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                        
                        Text("선수 검색에서 별 아이콘을 눌러\n관심 선수를 추가해보세요.")
                            .font(.system(size: 13))
                            .foregroundColor(.gray.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(favoriteManager.favoritePlayers) { player in
                                NavigationLink(destination: PlayerDetailView(player: player)) {
                                    playerRow(player)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func playerRow(_ player: Player) -> some View {
        HStack(spacing: 14) {
            // 선수 프로필 이미지 (실사 사진 또는 이니셜 원형 배지)
            if let photoUrl = player.photo, !photoUrl.isEmpty {
                RemoteImageView(urlString: photoUrl, size: 44, fallback: AnyView(fallbackAvatar(for: player)), isCircle: true)
            } else {
                fallbackAvatar(for: player)
            }
            
            // 선수 기본 정보
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                
                HStack(spacing: 6) {
                    Circle()
                        .fill(logoColor(for: player.teamName))
                        .frame(width: 8, height: 8)
                    
                    Text(player.teamName)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // 주요 기록 요약 및 삭제 버튼
            HStack(spacing: 16) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(player.goals)골 \(player.assists)도움")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.brandNavy)
                    
                    Text("\(player.passes)패스")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.gray.opacity(0.8))
                }
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation {
                        favoriteManager.toggleFavorite(playerID: player.id)
                    }
                }) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.yellow)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.015), radius: 6, x: 0, y: 3)
    }
    
    private func fallbackAvatar(for player: Player) -> some View {
        Circle()
            .fill(logoColor(for: player.teamName).opacity(0.1))
            .frame(width: 44, height: 44)
            .overlay(
                Text(String(player.name.prefix(1)))
                    .font(.system(size: 16, weight: .bold))
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

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoriteView()
        }
    }
}
