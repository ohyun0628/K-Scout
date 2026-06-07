import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    @State private var selectedPlayerId: Int? = nil
    @State private var showPlayerSummary = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // 그레이 베이스 백그라운드
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // 1. 공통 상단 헤더 타이틀 (시즌 선택 바인딩 제거 및 통산 스탯 표시)
                    HeaderTitleView(title: "선수 검색")
                        .overlay(
                            Text("22~24 통합 스탯")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.brandNavy.opacity(0.8))
                                .cornerRadius(12)
                                .padding(.trailing, 20),
                            alignment: .trailing
                        )
                    
                    // 2. 커스텀 서치 바
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("선수 이름 또는 구단 검색", text: $viewModel.searchText, onCommit: {
                                viewModel.searchPlayers(query: viewModel.searchText)
                            })
                                .foregroundColor(.primary)
                                .font(.system(size: 15))
                            
                            if !viewModel.searchText.isEmpty {
                                Button(action: {
                                    viewModel.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                    
                    // 3. 검색 결과 목록
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("선수 정보를 검색하는 중...")
                        Spacer()
                    } else if viewModel.filteredPlayers.isEmpty {
                        Spacer()
                        VStack(spacing: 12) {
                            Image(systemName: "person.fill.questionmark")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text(viewModel.searchText.isEmpty ? "최근 검색 기록이 없습니다." : "검색 결과와 일치하는 선수가 없습니다.")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                // 최근 검색어일 경우 타이틀 표시
                                if viewModel.searchText.isEmpty && !viewModel.filteredPlayers.isEmpty {
                                    HStack {
                                        Text("최근 검색 선수")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            withAnimation {
                                                viewModel.clearRecentSearches()
                                            }
                                        }) {
                                            Text("전체 삭제")
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.top, 4)
                                    .padding(.bottom, 2)
                                }
                                
                                ForEach(viewModel.filteredPlayers) { player in
                                    SwipeableRow(
                                        isEnable: viewModel.searchText.isEmpty,
                                        onDelete: {
                                            viewModel.removeRecentSearch(player)
                                        },
                                        onTap: {
                                            self.selectedPlayerId = player.id
                                            self.showPlayerSummary = true
                                            viewModel.addRecentSearch(player)
                                        }
                                    ) {
                                        playerRow(player)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedPlayerId) { id in
                PlayerSummarySheet(playerId: id, season: 2024)
            }
        }
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
            
            // 주요 기록 요약 표시
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(player.goals)골 \(player.assists)도움")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.brandNavy)
                
                Text("\(player.passes)패스")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.8))
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

struct SwipeableRow<Content: View>: View {
    let isEnable: Bool
    let onDelete: () -> Void
    let onTap: () -> Void
    let content: Content
    
    @State private var offset: CGFloat = 0
    @State private var isSwiped: Bool = false
    
    init(isEnable: Bool, onDelete: @escaping () -> Void, onTap: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.isEnable = isEnable
        self.onDelete = onDelete
        self.onTap = onTap
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isEnable {
                Button(action: {
                    withAnimation {
                        onDelete()
                        offset = 0
                        isSwiped = false
                    }
                }) {
                    ZStack {
                        Color.red
                            .cornerRadius(16)
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    .frame(width: 70)
                }
            }
            
            Button(action: {
                if isSwiped {
                    withAnimation {
                        offset = 0
                        isSwiped = false
                    }
                } else {
                    onTap()
                }
            }) {
                content
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x: offset)
            .gesture(
                isEnable ? DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                            offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if value.translation.width < -60 {
                                offset = -80
                                isSwiped = true
                            } else {
                                offset = 0
                                isSwiped = false
                            }
                        }
                    }
                : nil
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
