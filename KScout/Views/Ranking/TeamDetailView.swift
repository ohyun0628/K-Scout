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
            // 그레이 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 커스텀 내비게이션 바 & 프로필 헤더
                profileHeaderView
                
                // 2. 탭 셀렉터
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedTab = 0
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text("경기 일정 및 결과")
                                .font(.system(size: 15, weight: .bold))
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
                            Text("선수단 득점 현황")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(selectedTab == 1 ? Color.brandNavy : .gray)
                            
                            Rectangle()
                                .fill(selectedTab == 1 ? Color.brandNavy : Color.clear)
                                .frame(height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.white)
                
                // 3. 메인 콘텐츠
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("팀 정보를 불러오는 중...")
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            if selectedTab == 0 {
                                fixturesListView
                            } else {
                                squadListView
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchData()
        }
    }
    
    // MARK: - Subviews
    
    private var profileHeaderView: some View {
        VStack(spacing: 16) {
            // 상단 백 버튼 & 타이틀
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                        Text("순위표")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                }
                
                Spacer()
                
                Text("\(String(viewModel.season)) 시즌")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(20)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            // 팀 정보 메인 대시보드
            HStack(spacing: 20) {
                // 팀 가상 엠블럼 프레임
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    Text(String(viewModel.standing.teamName.prefix(2)))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .bottom, spacing: 8) {
                        Text(viewModel.standing.teamName)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(viewModel.standing.league == 1 ? "K리그1" : "K리그2")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(4)
                            .padding(.bottom, 3)
                    }
                    
                    Text("\(viewModel.standing.rank)위")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.orange)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            // 주요 스탯 그리드
            HStack(spacing: 0) {
                statBox(title: "승점", value: "\(viewModel.standing.points)")
                divider
                statBox(title: "경기", value: "\(viewModel.standing.played)")
                divider
                statBox(title: "승/무/패", value: "\(viewModel.standing.won)승 \(viewModel.standing.draw)무 \(viewModel.standing.lost)패")
                divider
                statBox(title: "득실차", value: "\(viewModel.standing.goalsDiff > 0 ? "+" : "")\(viewModel.standing.goalsDiff)")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.brandNavy, Color(red: 25/255, green: 40/255, blue: 75/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.2))
            .frame(width: 1, height: 24)
    }
    
    private func statBox(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - 경기 일정 및 결과 리스트
    private var fixturesListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("전체 경기 정보")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.brandNavy)
                .padding(.horizontal, 16)
            
            ForEach(viewModel.fixtures) { match in
                HStack(spacing: 12) {
                    // 승무패 매칭 뱃지 (종료된 경기 기준)
                    if match.status == "FT" {
                        winLossBadge(for: match)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text("예")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(match.time)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text(match.stadium)
                                .font(.system(size: 11))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        
                        HStack {
                            // 홈팀
                            Text(match.homeTeam)
                                .font(.system(size: 14, weight: match.homeTeam == viewModel.standing.teamName ? .bold : .regular))
                                .foregroundColor(match.homeTeam == viewModel.standing.teamName ? Color.brandNavy : .primary)
                            
                            Spacer()
                            
                            // 스코어 또는 경기 대기 상태
                            if let homeScore = match.homeScore, let awayScore = match.awayScore {
                                Text("\(homeScore) : \(awayScore)")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(Color.brandNavy)
                                    .frame(width: 50)
                            } else {
                                Text("VS")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.gray)
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                            
                            // 원정팀
                            Text(match.awayTeam)
                                .font(.system(size: 14, weight: match.awayTeam == viewModel.standing.teamName ? .bold : .regular))
                                .foregroundColor(match.awayTeam == viewModel.standing.teamName ? Color.brandNavy : .primary)
                        }
                    }
                }
                .padding(14)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                .padding(.horizontal, 16)
            }
        }
    }
    
    // 승무패 뱃지 연동 헬퍼
    private func winLossBadge(for match: MockMatch) -> some View {
        let isHome = match.homeTeam == viewModel.standing.teamName
        guard let homeScore = match.homeScore, let awayScore = match.awayScore else {
            return Circle().fill(Color.gray).frame(width: 32, height: 32)
        }
        
        let isWin = isHome ? (homeScore > awayScore) : (awayScore > homeScore)
        let isDraw = homeScore == awayScore
        
        let text: String
        let color: Color
        
        if isWin {
            text = "승"
            color = Color.green
        } else if isDraw {
            text = "무"
            color = Color.gray
        } else {
            text = "패"
            color = Color.red
        }
        
        return Circle()
            .fill(color)
            .frame(width: 32, height: 32)
            .overlay(
                Text(text)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            )
    }
    
    // MARK: - 선수단 득점 리스트
    private var squadListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("선수단 주요 득점 기록")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.brandNavy)
                .padding(.horizontal, 16)
            
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
            } else {
                ForEach(Array(viewModel.squad.enumerated()), id: \.element.id) { index, player in
                    HStack(spacing: 12) {
                        // 등번호 또는 득점 순위 원형 인덱스
                        ZStack {
                            Circle()
                                .fill(Color.brandNavy.opacity(0.1))
                                .frame(width: 32, height: 32)
                            
                            Text("\(index + 1)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(player.name)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.primary)
                            
                            Text(player.teamName)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            statBadge(title: "득점", value: "\(player.goals)골", color: Color.green)
                            statBadge(title: "도움", value: "\(player.assists)도움", color: Color.blue)
                        }
                    }
                    .padding(14)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private func statBadge(title: String, value: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(color)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(color.opacity(0.1))
                .cornerRadius(4)
        }
    }
}
