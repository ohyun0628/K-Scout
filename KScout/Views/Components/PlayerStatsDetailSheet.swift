import SwiftUI

struct PlayerStatsDetailSheet: View {
    @ObservedObject var viewModel: RankingViewModel
    let selectedLeague: Int
    @State private var localStatType: String
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedPlayerId: Int? = nil
    @State private var showPlayerSummary = false
    
    init(viewModel: RankingViewModel, selectedLeague: Int, initialStatType: String) {
        self.viewModel = viewModel
        self.selectedLeague = selectedLeague
        self._localStatType = State(initialValue: initialStatType)
    }
    
    struct StatTab: Identifiable {
        var id: String { type }
        let title: String
        let type: String
    }
    
    private let tabs: [StatTab] = [
        StatTab(title: "득점", type: "goals"),
        StatTab(title: "도움", type: "assists"),
        StatTab(title: "공격포인트", type: "points"),
        StatTab(title: "MOM", type: "mom"),
        StatTab(title: "평균평점", type: "rating"),
        StatTab(title: "BEST11", type: "best11"),
        StatTab(title: "90분당 득점", type: "goalsPer90"),
        StatTab(title: "90분당 공포", type: "pointsPer90"),
        StatTab(title: "슈팅", type: "shots"),
        StatTab(title: "유효 슈팅", type: "shotsOnTarget"),
        StatTab(title: "출전 시간", type: "minutes")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. 헤더 (타이틀 및 닫기 버튼)
            HStack {
                Spacer()
                Text("선수 기록")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .padding(.bottom, 12)
            
            // 2. 가로 스크롤 탭 바 (네이버 스포츠 스타일)
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 20) {
                        ForEach(tabs) { tab in
                            Button(action: {
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                    localStatType = tab.type
                                }
                            }) {
                                VStack(spacing: 8) {
                                    Text(tab.title)
                                        .font(.system(size: 15, weight: localStatType == tab.type ? .bold : .medium))
                                        .foregroundColor(localStatType == tab.type ? Color.brandNavy : .gray)
                                    
                                    // 하단 인디케이터 바
                                    Rectangle()
                                        .fill(localStatType == tab.type ? Color.brandNavy : Color.clear)
                                        .frame(height: 2)
                                }
                            }
                            .id(tab.type)
                        }
                    }
                    .padding(.horizontal, 16)
                    .onAppear {
                        // 초기 선택된 탭 위치로 자동 스크롤
                        proxy.scrollTo(localStatType, anchor: .center)
                    }
                    .onChange(of: localStatType) { newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            
            Divider()
            
            // 3. 랭킹 리스트
            let rankings = viewModel.filteredPlayerRankings(forLeague: selectedLeague, type: localStatType)
            
            if rankings.isEmpty {
                VStack(spacing: 12) {
                    Spacer()
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("선수 기록이 아직 기록되지 않았습니다.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(rankings) { player in
                            HStack(spacing: 14) {
                                // 순위 뱃지 (골드, 실버, 브론즈 스타일)
                                ZStack {
                                    if player.rank == 1 {
                                        Circle()
                                            .fill(Color(red: 0.95, green: 0.75, blue: 0.0))
                                            .frame(width: 26, height: 26)
                                        Text("1")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    } else {
                                        Text("\(player.rank)")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(width: 28, alignment: .center)
                                
                                // 동그란 실사 프로필 사진 이미지 뷰
                                PlayerAvatarView(playerName: player.playerName, teamName: player.teamName, photoURL: player.photoURL, size: 42)
                                
                                // 선수명 및 소속팀 (팀 로고 배지 추가)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(player.playerName)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.primary)
                                    
                                    HStack(spacing: 4) {
                                        TeamLogoView(teamName: player.teamName, size: 12)
                                        
                                        Text(player.teamName)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                Spacer()
                                
                                // 우측 파란색 값 하이라이트
                                Text(statValueString(for: player))
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.brandNavy)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.selectedPlayerId = player.id
                                self.showPlayerSummary = true
                            }
                            
                            Divider()
                                .padding(.leading, 60)
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showPlayerSummary) {
            PlayerSummarySheet(playerId: selectedPlayerId ?? 0)
        }
    }
    
    // MARK: - 스탯에 맞는 값 반환 함수
    private func statValueString(for player: PlayerRanking) -> String {
        switch localStatType {
        case "goals":
            return "\(player.goals)골"
        case "assists":
            return "\(player.assists)도움"
        case "points":
            return "\(player.attackPoints)P"
        case "pkGoals":
            return "\(player.pkGoals)골"
        case "played":
            return "\(player.played)경기"
        case "mom":
            return "\(player.momCount)회"
        case "rating":
            return String(format: "%.1f점", player.avgRating)
        case "best11":
            return "\(player.best11Count)회"
        case "shots":
            return "\(player.shots)슈팅"
        case "shotsOnTarget":
            return "\(player.shotsOnTarget)유효"
        case "minutes":
            return String(format: "%d분", player.playedMinutes)
        default:
            return "\(player.statCount)"
        }
    }
}
