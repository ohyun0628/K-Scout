import SwiftUI

struct PlayerSummarySheet: View {
    let playerId: Int
    var season: Int = 2024
    @StateObject private var viewModel = PlayerSummaryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // For navigation to full detail
    @State private var navigateToDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("선수 정보 불러오는 중...")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("데이터를 불러오지 못했습니다.")
                            .font(.system(size: 16, weight: .bold))
                        Text(error)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else if let detail = viewModel.playerDetail {
                    contentView(detail)
                }
                
                // Navigation Link hidden
                VStack {
                    NavigationLink(
                        destination: PlayerDetailView(player: convertToPlayer(viewModel.playerDetail), season: season),
                        isActive: $navigateToDetail,
                        label: { EmptyView() }
                    )
                }.frame(width: 0, height: 0).hidden()
            }
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .semibold))
            })
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchPlayer(id: playerId, season: season)
            }
        }
    }
    
    @ViewBuilder
    private func contentView(_ detail: PlayerDetailItem) -> some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 32) {
                    // Profile Header
                    profileHeader(detail)
                    
                    // Info Cards
                    infoCards(detail)
                    
                    // Season Records
                    seasonRecords(detail)
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            // Bottom Button
            Button(action: {
                navigateToDetail = true
            }) {
                Text("기록 더보기")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.brandNavy)
            }
        }
    }
    
    private func profileHeader(_ detail: PlayerDetailItem) -> some View {
        let translatedTeamName = KoreanTranslationService.translateTeam(detail.statistics.first?.team.name ?? "")
        let teamColor = logoColor(for: translatedTeamName)
        
        return VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [teamColor.opacity(0.5), teamColor.opacity(0.1), .white]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 100)
                    .cornerRadius(16)
                    
                ZStack(alignment: .bottomTrailing) {
                    RemoteImageView(
                        urlString: detail.player.photo ?? "",
                        size: 90,
                        fallback: AnyView(Circle().fill(Color.gray.opacity(0.1)).overlay(Image(systemName: "person.fill").font(.system(size: 40)).foregroundColor(.gray.opacity(0.5)))),
                        isCircle: true
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    
                    if let teamLogo = detail.statistics.first?.team.logo {
                        RemoteImageView(
                            urlString: teamLogo,
                            size: 28,
                            fallback: AnyView(Circle().fill(Color.white)),
                            isCircle: true
                        )
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
                        .offset(x: 4, y: 4)
                    }
                }
                .offset(y: 30) // Shift avatar down slightly over the edge
            }
            .padding(.bottom, 40) // Make space for the shifted avatar
            
            Text(KoreanTranslationService.translatePlayer(detail.player.name))
                .font(.system(size: 22, weight: .bold))
        }
    }
    
    private func infoCards(_ detail: PlayerDetailItem) -> some View {
        let pos = detail.statistics.first?.games?.position ?? "-"
        let positionKR = translatePosition(pos)
        
        // Sometimes number is provided, sometimes nil. Handle it properly.
        let numberStr: String
        if let num = detail.statistics.first?.games?.number {
            // API sometimes returns 0 or weird formats, but typically Int
            numberStr = "No.\(num)"
        } else {
            numberStr = "-"
        }
        
        return HStack(spacing: 10) {
            infoCard(title: "등번호", value: numberStr)
            infoCard(title: "포지션", value: positionKR)
            infoCard(title: "출생", value: detail.player.birth?.date ?? "-")
            infoCard(title: "신장", value: detail.player.height ?? "-")
        }
    }
    
    private func translatePosition(_ pos: String) -> String {
        switch pos {
        case "Attacker": return "FW"
        case "Midfielder": return "MF"
        case "Defender": return "DF"
        case "Goalkeeper": return "GK"
        default: return pos
        }
    }
    
    private func infoCard(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private func seasonRecords(_ detail: PlayerDetailItem) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            let leagueName = detail.statistics.first?.league?.name ?? "K리그1"
            
            HStack(spacing: 6) {
                Text("\(leagueName) 통합 기록")
                    .font(.system(size: 16, weight: .bold))
                Image(systemName: "info.circle")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            let stats = detail.statistics.first
            let apps = stats?.games?.appearences ?? 0
            let goals = stats?.goals?.total ?? 0
            let assists = stats?.goals?.assists ?? 0
            let shots = stats?.shots?.total ?? 0
            let passes = stats?.passes?.total ?? 0
            let tackles = stats?.tackles?.total ?? 0
            
            let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]
            
            LazyVGrid(columns: columns, spacing: 12) {
                statCard(icon: "figure.run", title: "경기", value: "\(apps)")
                statCard(icon: "soccerball", title: "득점", value: "\(goals)")
                statCard(icon: "shoe.2", title: "도움", value: "\(assists)")
                statCard(icon: "flame.fill", title: "슈팅", value: "\(shots)")
                statCard(icon: "arrow.left.and.right", title: "패스", value: "\(passes)")
                statCard(icon: "shield.fill", title: "태클", value: "\(tackles)")
            }
            .padding(.top, 4)
        }
    }
    
    private func statCard(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.brandNavy.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color.brandNavy)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray)
                Text(value)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
    
    private func convertToPlayer(_ detail: PlayerDetailItem?) -> Player {
        guard let detail = detail else {
            return Player(id: 0, name: "-", photo: nil, teamName: "-", leagueName: nil, goals: 0, assists: 0, shots: 0, passes: 0, defense: 0)
        }
        let stats = detail.statistics.first
        return Player(
            id: detail.player.id,
            name: detail.player.name,
            photo: detail.player.photo,
            teamName: KoreanTranslationService.translateTeam(stats?.team.name ?? "-"),
            leagueName: stats?.league?.name,
            goals: stats?.goals?.total ?? 0,
            assists: stats?.goals?.assists ?? 0,
            shots: stats?.shots?.total ?? 0,
            passes: stats?.passes?.total ?? 0,
            defense: stats?.tackles?.total ?? 0
        )
    }
    
    // K리그 실전 매칭을 위한 팀별 브랜드 컬러 매핑 함수
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
        } else if teamName.contains("광주") {
            return Color(red: 0.9, green: 0.8, blue: 0.2)
        } else if teamName.contains("인천") {
            return Color(red: 0.1, green: 0.2, blue: 0.8)
        } else if teamName.contains("제주") {
            return Color(red: 0.9, green: 0.4, blue: 0.1)
        } else if teamName.contains("대전") {
            return Color(red: 0.4, green: 0.1, blue: 0.2)
        } else if teamName.contains("대구") {
            return Color(red: 0.4, green: 0.7, blue: 0.9)
        } else if teamName.contains("강원") {
            return Color(red: 0.9, green: 0.5, blue: 0.1)
        } else if teamName.contains("김천") {
            return Color(red: 0.8, green: 0.1, blue: 0.2)
        } else {
            return Color.brandNavy
        }
    }
}
