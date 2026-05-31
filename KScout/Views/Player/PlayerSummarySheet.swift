import SwiftUI

struct PlayerSummarySheet: View {
    let playerId: Int
    @StateObject private var viewModel = PlayerSummaryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // For navigation to full detail
    @State private var navigateToDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    ProgressView("선수 정보 불러오는 중...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let detail = viewModel.playerDetail {
                    contentView(detail)
                }
                
                // Navigation Link hidden
                NavigationLink(
                    destination: PlayerDetailView(player: convertToPlayer(viewModel.playerDetail)),
                    isActive: $navigateToDetail,
                    label: { EmptyView() }
                )
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
                viewModel.fetchPlayer(id: playerId)
            }
        }
    }
    
    @ViewBuilder
    private func contentView(_ detail: PlayerDetailItem) -> some View {
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
                .background(Color(red: 220/255, green: 180/255, blue: 60/255)) // Yellow gold color
        }
    }
    
    private func profileHeader(_ detail: PlayerDetailItem) -> some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                RemoteImageView(
                    urlString: detail.player.photo ?? "",
                    size: 90,
                    fallback: AnyView(Circle().fill(Color.gray.opacity(0.1)).overlay(Image(systemName: "person.fill").font(.system(size: 40)).foregroundColor(.gray.opacity(0.5)))),
                    isCircle: true
                )
                
                if let teamLogo = detail.statistics.first?.team.logo {
                    RemoteImageView(
                        urlString: teamLogo,
                        size: 28,
                        fallback: AnyView(Circle().fill(Color.white)),
                        isCircle: true
                    )
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                    .offset(x: 4, y: 4)
                }
            }
            
            Text(KoreanTranslationService.translatePlayer(detail.player.name))
                .font(.system(size: 22, weight: .bold))
        }
    }
    
    private func infoCards(_ detail: PlayerDetailItem) -> some View {
        HStack(spacing: 10) {
            infoCard(title: "등번호", value: detail.statistics.first?.games?.number.map { "No.\($0)" } ?? "-")
            infoCard(title: "포지션", value: detail.statistics.first?.games?.position ?? "-")
            infoCard(title: "출생", value: detail.player.birth?.date ?? "-")
            infoCard(title: "신장", value: detail.player.height ?? "-")
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
            HStack(spacing: 6) {
                Text("K리그1 2024 시즌 기록")
                    .font(.system(size: 16, weight: .bold))
                Image(systemName: "info.circle")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            let stats = detail.statistics.first
            let apps = stats?.games?.appearences ?? 0
            let goals = stats?.goals?.total ?? 0
            let assists = stats?.goals?.assists ?? 0
            let shots = stats?.shots?.total ?? 0
            let passes = stats?.passes?.total ?? 0
            let tackles = stats?.tackles?.total ?? 0
            
            VStack(spacing: 16) {
                recordRow(title: "경기", value: "\(apps)")
                recordRow(title: "득점", value: "\(goals)")
                recordRow(title: "도움", value: "\(assists)")
                recordRow(title: "슈팅", value: "\(shots)")
                recordRow(title: "패스", value: "\(passes)")
                recordRow(title: "태클", value: "\(tackles)")
            }
            .padding(.top, 4)
        }
    }
    
    private func recordRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.system(size: 15, weight: .medium))
        }
    }
    
    private func convertToPlayer(_ detail: PlayerDetailItem?) -> Player {
        guard let detail = detail else {
            return Player(id: 0, name: "-", photo: nil, teamName: "-", goals: 0, assists: 0, shots: 0, passes: 0, defense: 0)
        }
        let stats = detail.statistics.first
        return Player(
            id: detail.player.id,
            name: detail.player.name,
            photo: detail.player.photo,
            teamName: KoreanTranslationService.translateTeam(stats?.team.name ?? "-"),
            goals: stats?.goals?.total ?? 0,
            assists: stats?.goals?.assists ?? 0,
            shots: stats?.shots?.total ?? 0,
            passes: stats?.passes?.total ?? 0,
            defense: stats?.tackles?.total ?? 0
        )
    }
}
