import SwiftUI

struct TeamDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: TeamDetailViewModel
    @State private var selectedTab = 0 // 0: 경기 일정/결과, 1: 선수단 스탯
    
    @State private var selectedPlayerId: Int? = nil
    @State private var showPlayerSummary = false
    
    init(standing: Standing, season: Int) {
        _viewModel = StateObject(wrappedValue: TeamDetailViewModel(standing: standing, season: season))
    }
    
    var body: some View {
        ZStack {
            // 네이버 스포츠 스타일의 깨끗한 그레이톤 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 커스텀 라이트 테마 내비게이션 바
                customNavBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // 2. 프리미엄 화이트 프로필 카드 (팀 정보)
                        profileHeaderCard
                        
                        // 3. 주요 성적 스탯 그리드
                        statsGrid
                        
                        // 4. 네이버 스포츠 스타일 탭 셀렉터
                        tabSelector
                        
                        // 5. 콘텐츠 영역
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView("기록을 불러오는 중...")
                                Spacer()
                            }
                            .frame(height: 200)
                        } else {
                            if selectedTab == 0 {
                                fixturesListView
                            } else {
                                squadListView
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchData()
        }
        .sheet(item: $selectedPlayerId) { id in
            PlayerSummarySheet(playerId: id, season: viewModel.season)
        }
    }
    
    // MARK: - Subviews
    
    // 1. 라이트 테마 내비게이션 바
    private var customNavBar: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                    Text("순위표")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(Color.brandNavy)
                .padding(.vertical, 8)
            }
            
            Spacer()
            
            Text("\(String(viewModel.season)) 시즌")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color.brandNavy)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.brandNavy.opacity(0.08))
                .cornerRadius(20)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
    }
    
    // 2. 화이트 프로필 헤더 카드
    private var profileHeaderCard: some View {
        HStack(spacing: 16) {
            // 팀 서클 엠블럼
            ZStack {
                Circle()
                    .fill(logoColor(for: viewModel.standing.teamName).opacity(0.1))
                    .frame(width: 74, height: 74)
                
                Circle()
                    .stroke(logoColor(for: viewModel.standing.teamName).opacity(0.3), lineWidth: 2)
                    .frame(width: 74, height: 74)
                
                Text(String(viewModel.standing.teamName.prefix(2)))
                    .font(.system(size: 22, weight: .black))
                    .foregroundColor(logoColor(for: viewModel.standing.teamName))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 8) {
                    Text(viewModel.standing.teamName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(viewModel.standing.league == 1 ? "K리그1" : "K리그2")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                }
                
                // 순위 정보 뱃지
                HStack(spacing: 4) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 11))
                        .foregroundColor(Color(red: 230/255, green: 170/255, blue: 0/255))
                    
                    Text("리그 \(viewModel.standing.rank)위")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color(red: 21/255, green: 112/255, blue: 183/255))
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 4)
                .background(Color(red: 21/255, green: 112/255, blue: 183/255).opacity(0.08))
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 16)
    }
    
    // 3. 주요 스탯 그리드
    private var statsGrid: some View {
        HStack(spacing: 8) {
            statCard(title: "승점", value: "\(viewModel.standing.points)", isHighlight: true)
            statCard(title: "경기수", value: "\(viewModel.standing.played)", isHighlight: false)
            statCard(title: "승/무/패", value: "\(viewModel.standing.won)승\(viewModel.standing.draw)무\(viewModel.standing.lost)패", isHighlight: false)
            statCard(title: "득실차", value: "\(viewModel.standing.goalsDiff > 0 ? "+" : "")\(viewModel.standing.goalsDiff)", isHighlight: false)
        }
        .padding(.horizontal, 16)
    }
    
    private func statCard(title: String, value: String, isHighlight: Bool) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(isHighlight ? Color(red: 21/255, green: 112/255, blue: 183/255) : .primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
    }
    
    // 4. 네이버 스포츠 스타일 탭 셀렉터
    private var tabSelector: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    selectedTab = 0
                }
            }) {
                VStack(spacing: 8) {
                    Text("경기 일정 및 결과")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(selectedTab == 0 ? Color.brandNavy : .gray)
                    
                    Rectangle()
                        .fill(selectedTab == 0 ? Color.brandNavy : Color.clear)
                        .frame(height: 3)
                }
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    selectedTab = 1
                }
            }) {
                VStack(spacing: 8) {
                    Text("선수단 득점 도움 현황")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(selectedTab == 1 ? Color.brandNavy : .gray)
                    
                    Rectangle()
                        .fill(selectedTab == 1 ? Color.brandNavy : Color.clear)
                        .frame(height: 3)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
    }
    
    // 5. 경기 일정 리스트 뷰
    private var fixturesListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("전체 경기 정보")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.brandNavy)
                .padding(.horizontal, 16)
                .padding(.top, 4)
            
            if viewModel.fixtures.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 32))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("경기 정보가 없습니다.")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .padding(.horizontal, 16)
            } else {
                ForEach(viewModel.fixtures) { match in
                    NavigationLink(destination: MatchDetailView(match: match)) {
                        HStack(spacing: 12) {
                        // 결과에 따른 전적 서클 뱃지 (네이버 톤 매칭)
                        if match.status == "FT" {
                            winLossBadge(for: match)
                        } else {
                            Circle()
                                .fill(Color(.systemGray6))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text("예")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.secondary)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(match.time)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(match.stadium)
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            
                            HStack {
                                // 홈 팀
                                Text(match.homeTeam)
                                    .font(.system(size: 14, weight: match.homeTeam == viewModel.standing.teamName ? .bold : .medium))
                                    .foregroundColor(match.homeTeam == viewModel.standing.teamName ? Color.brandNavy : .primary)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                // 스코어보드 스타일
                                if let homeScore = match.homeScore, let awayScore = match.awayScore {
                                    Text("\(homeScore) : \(awayScore)")
                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                        .foregroundColor(Color.brandNavy)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(6)
                                } else {
                                    Text("VS")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(6)
                                }
                                
                                Spacer()
                                
                                // 원정 팀
                                Text(match.awayTeam)
                                    .font(.system(size: 14, weight: match.awayTeam == viewModel.standing.teamName ? .bold : .medium))
                                    .foregroundColor(match.awayTeam == viewModel.standing.teamName ? Color.brandNavy : .primary)
                                    .lineLimit(1)
                            }
                        }
                        }
                        .padding(14)
                        .background(Color(.systemBackground))
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 16)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    // 승무패 광채 뱃지 (네이버 스포츠 전적 서클 기준 매칭)
    @ViewBuilder
    private func winLossBadge(for match: MockMatch) -> some View {
        let isHome = match.homeTeam == viewModel.standing.teamName
        if let homeScore = match.homeScore, let awayScore = match.awayScore {
            let isWin = isHome ? (homeScore > awayScore) : (awayScore > homeScore)
            let isDraw = homeScore == awayScore
            
            let text = isWin ? "승" : (isDraw ? "무" : "패")
            
            // 승: 초록계열, 무: 회색계열, 패: 파란계열
            let textColor = isWin ? Color(red: 2/255, green: 114/255, blue: 76/255) :
                            (isDraw ? Color(red: 102/255, green: 102/255, blue: 102/255) : Color(red: 21/255, green: 112/255, blue: 183/255))
            let bgColor = isWin ? Color(red: 224/255, green: 245/255, blue: 233/255) :
                          (isDraw ? Color(red: 242/255, green: 242/255, blue: 242/255) : Color(red: 230/255, green: 242/255, blue: 250/255))
            let borderColor = isWin ? Color(red: 136/255, green: 218/255, blue: 181/255) :
                              (isDraw ? Color(red: 217/255, green: 217/255, blue: 217/255) : Color(red: 163/255, green: 204/255, blue: 235/255))
            
            Circle()
                .fill(bgColor)
                .frame(width: 32, height: 32)
                .overlay(
                    Text(text)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(textColor)
                )
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: 0.5)
                )
        } else {
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 32, height: 32)
        }
    }
    
    // 6. 선수단 스탯 리스트 뷰
    private var squadListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("선수단 주요 기록")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.brandNavy)
                .padding(.horizontal, 16)
                .padding(.top, 4)
            
            if viewModel.squad.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "person.3")
                        .font(.system(size: 32))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("선수단 기록 정보가 없습니다.")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .padding(.horizontal, 16)
            } else {
                ForEach(Array(viewModel.squad.enumerated()), id: \.element.id) { index, player in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray6))
                                .frame(width: 32, height: 32)
                            
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(KoreanTranslationService.translatePlayer(player.name))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                let role = getPlayerRole(player: player)
                                Text(role)
                                    .font(.system(size: 9, weight: .black))
                                    .foregroundColor(roleColor(role: role))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 1)
                                    .background(roleColor(role: role).opacity(0.12))
                                    .cornerRadius(4)
                            }
                            
                            Text(player.teamName)
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            statBadge(title: "득점", value: "\(player.goals)골", color: Color(red: 2/255, green: 114/255, blue: 76/255))
                            statBadge(title: "도움", value: "\(player.assists)도움", color: Color(red: 21/255, green: 112/255, blue: 183/255))
                        }
                    }
                    .padding(14)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                    .padding(.horizontal, 16)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.selectedPlayerId = player.id
                        self.showPlayerSummary = true
                    }
                }
            }
        }
    }
    
    private func statBadge(title: String, value: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 12, weight: .bold))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .foregroundColor(color)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(color.opacity(0.08))
                .cornerRadius(4)
        }
    }
    
    private func getPlayerRole(player: Player) -> String {
        if player.goals > 5 {
            return "FW"
        } else if player.assists > 3 {
            return "MF"
        } else if player.defense > 50 {
            return "DF"
        } else {
            return "MF"
        }
    }
    
    private func roleColor(role: String) -> Color {
        switch role {
        case "FW": return .red
        case "MF": return .green
        case "DF": return .blue
        default: return .gray
        }
    }
    
    // 로고 매칭 헬퍼
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
