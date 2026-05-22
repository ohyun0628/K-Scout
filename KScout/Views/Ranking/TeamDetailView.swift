import SwiftUI

struct TeamDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: TeamDetailViewModel
    @State private var selectedTab = 0 // 0: 경기 일정/결과, 1: 선수단 스탯
    
    init(standing: Standing, season: Int) {
        _viewModel = StateObject(wrappedValue: TeamDetailViewModel(standing: standing, season: season))
    }
    
    var body: some View {
        ZStack {
            // 다크 모드 프리미엄 그라데이션 백그라운드
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 10/255, green: 18/255, blue: 36/255),
                    Color(red: 20/255, green: 38/255, blue: 74/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 커스텀 프리미엄 내비게이션 바
                customNavBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // 2. 글래스모피즘 헤더 카드 (팀 정보)
                        profileHeaderCard
                        
                        // 3. 주요 시즌 성적 스탯 그리드
                        statsGrid
                        
                        // 4. 슬라이더 타입 세그먼트 컨트롤 탭
                        tabSelector
                        
                        // 5. 선택된 탭 콘텐츠 영역
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView("기록을 불러오는 중...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .foregroundColor(.white.opacity(0.7))
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
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchData()
        }
    }
    
    // MARK: - Subviews
    
    // 1. 내비게이션 바
    private var customNavBar: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                    Text("순위표")
                        .font(.system(size: 15, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.vertical, 8)
            }
            
            Spacer()
            
            Text("\(String(viewModel.season)) 시즌")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.12))
                .cornerRadius(20)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
    
    // 2. 프로필 헤더 카드
    private var profileHeaderCard: some View {
        HStack(spacing: 20) {
            // 골드 그라데이션 서클 테두리가 들어간 팀 엠블럼 프레임
            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 255/255, green: 215/255, blue: 0/255),
                                Color(red: 212/255, green: 175/255, blue: 55/255).opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(red: 255/255, green: 215/255, blue: 0/255).opacity(0.2), radius: 6)
                
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 74, height: 74)
                
                Text(String(viewModel.standing.teamName.prefix(2)))
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    Text(viewModel.standing.teamName)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(viewModel.standing.league == 1 ? "K리그1" : "K리그2")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                }
                
                // 골드 테마 랭킹 뱃지
                HStack(spacing: 4) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 255/255, green: 215/255, blue: 0/255))
                    
                    Text("리그 \(viewModel.standing.rank)위")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(Color(red: 255/255, green: 215/255, blue: 0/255))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color(red: 255/255, green: 215/255, blue: 0/255).opacity(0.12))
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.04))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
    
    // 3. 주요 스탯 그리드
    private var statsGrid: some View {
        HStack(spacing: 10) {
            statCard(title: "승점", value: "\(viewModel.standing.points)", isHighlight: true)
            statCard(title: "경기수", value: "\(viewModel.standing.played)", isHighlight: false)
            statCard(title: "승/무/패", value: "\(viewModel.standing.won)승\(viewModel.standing.draw)무\(viewModel.standing.lost)패", isHighlight: false)
            statCard(title: "득실차", value: "\(viewModel.standing.goalsDiff > 0 ? "+" : "")\(viewModel.standing.goalsDiff)", isHighlight: false)
        }
        .padding(.horizontal, 16)
    }
    
    private func statCard(title: String, value: String, isHighlight: Bool) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white.opacity(0.4))
            
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(isHighlight ? Color(red: 255/255, green: 215/255, blue: 0/255) : .white)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.03))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
    }
    
    // 4. 슬라이더 세그먼트 셀렉터
    private var tabSelector: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    selectedTab = 0
                }
            }) {
                Text("경기 일정 및 결과")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.4))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(selectedTab == 0 ? Color.white.opacity(0.12) : Color.clear)
                    .cornerRadius(10)
            }
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    selectedTab = 1
                }
            }) {
                Text("선수단 득점 현황")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.4))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(selectedTab == 1 ? Color.white.opacity(0.12) : Color.clear)
                    .cornerRadius(10)
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
    
    // 5. 경기 일정 리스트 뷰
    private var fixturesListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("전체 경기 정보")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            
            if viewModel.fixtures.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.3))
                    Text("경기 정보가 없습니다.")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                ForEach(viewModel.fixtures) { match in
                    HStack(spacing: 12) {
                        // 결과에 따른 전적 서클 뱃지
                        if match.status == "FT" {
                            winLossBadge(for: match)
                        } else {
                            Circle()
                                .fill(Color.white.opacity(0.08))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text("예")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.white.opacity(0.4))
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(match.time)
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.4))
                                Spacer()
                                Text(match.stadium)
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.3))
                                    .lineLimit(1)
                            }
                            
                            HStack {
                                // 홈 팀
                                Text(match.homeTeam)
                                    .font(.system(size: 14, weight: match.homeTeam == viewModel.standing.teamName ? .bold : .medium))
                                    .foregroundColor(match.homeTeam == viewModel.standing.teamName ? Color(red: 255/255, green: 215/255, blue: 0/255) : .white)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                // 스코어 전광판 스타일
                                if let homeScore = match.homeScore, let awayScore = match.awayScore {
                                    Text("\(homeScore) : \(awayScore)")
                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.black.opacity(0.4))
                                        .cornerRadius(6)
                                } else {
                                    Text("VS")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white.opacity(0.3))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.black.opacity(0.2))
                                        .cornerRadius(6)
                                }
                                
                                Spacer()
                                
                                // 원정 팀
                                Text(match.awayTeam)
                                    .font(.system(size: 14, weight: match.awayTeam == viewModel.standing.teamName ? .bold : .medium))
                                    .foregroundColor(match.awayTeam == viewModel.standing.teamName ? Color(red: 255/255, green: 215/255, blue: 0/255) : .white)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(14)
                    .background(Color.white.opacity(0.03))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white.opacity(0.05), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    // 승무패 광채 뱃지
    @ViewBuilder
    private func winLossBadge(for match: MockMatch) -> some View {
        let isHome = match.homeTeam == viewModel.standing.teamName
        if let homeScore = match.homeScore, let awayScore = match.awayScore {
            let isWin = isHome ? (homeScore > awayScore) : (awayScore > homeScore)
            let isDraw = homeScore == awayScore
            
            let text = isWin ? "승" : (isDraw ? "무" : "패")
            let color = isWin ? Color.green : (isDraw ? Color.gray : Color.red)
            
            Circle()
                .fill(color)
                .frame(width: 32, height: 32)
                .overlay(
                    Text(text)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                )
                .shadow(color: color.opacity(0.3), radius: 4)
        } else {
            Circle()
                .fill(Color.gray)
                .frame(width: 32, height: 32)
        }
    }
    
    // 6. 선수단 스탯 리스트 뷰
    private var squadListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("선수단 주요 기록")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            
            if viewModel.squad.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "person.3")
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.3))
                    Text("선수단 기록 정보가 없습니다.")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                ForEach(Array(viewModel.squad.enumerated()), id: \.element.id) { index, player in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.06))
                                .frame(width: 32, height: 32)
                            
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(player.name)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                
                                let role = getPlayerRole(player: player)
                                Text(role)
                                    .font(.system(size: 9, weight: .black))
                                    .foregroundColor(roleColor(role: role))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 1)
                                    .background(roleColor(role: role).opacity(0.15))
                                    .cornerRadius(4)
                            }
                            
                            Text(player.teamName)
                                .font(.system(size: 11))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            statBadge(title: "득점", value: "\(player.goals)골", color: .green)
                            statBadge(title: "도움", value: "\(player.assists)도움", color: .blue)
                        }
                    }
                    .padding(14)
                    .background(Color.white.opacity(0.03))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white.opacity(0.05), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private func statBadge(title: String, value: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.4))
            
            Text(value)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(color)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(color.opacity(0.15))
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
}
