import SwiftUI

struct MatchDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: MatchDetailViewModel
    @State private var selectedTab = 0 // 0: 라인업, 1: 경기 기록, 2: 스탯
    
    init(match: MockMatch) {
        _viewModel = StateObject(wrappedValue: MatchDetailViewModel(match: match))
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                customNavBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        scoreboardCard
                        tabSelector
                        
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView("데이터를 불러오는 중...")
                                Spacer()
                            }
                            .frame(height: 200)
                        } else {
                            if selectedTab == 0 {
                                lineupsView
                            } else if selectedTab == 1 {
                                eventsView
                            } else {
                                statsView
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchMatchDetails()
        }
    }
    
    private var customNavBar: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                    Text("뒤로")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(Color.brandNavy)
                .padding(.vertical, 8)
            }
            Spacer()
            Text("경기 상세")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.brandNavy)
            Spacer()
            // Placeholder to balance HStack
            Button(action: {}) {
                Text("    ")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
    }
    
    private var scoreboardCard: some View {
        VStack(spacing: 12) {
            Text(viewModel.match.time)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            
            HStack(spacing: 0) {
                // Home Team
                VStack(spacing: 8) {
                    Text(viewModel.match.homeTeam)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                }
                
                // Score
                VStack(spacing: 4) {
                    if let homeScore = viewModel.match.homeScore, let awayScore = viewModel.match.awayScore {
                        Text("\(homeScore) : \(awayScore)")
                            .font(.system(size: 32, weight: .black, design: .monospaced))
                            .foregroundColor(.white)
                    } else {
                        Text("VS")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .frame(width: 100)
                
                // Away Team
                VStack(spacing: 8) {
                    Text(viewModel.match.awayTeam)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Text(viewModel.match.stadium)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.brandNavy, Color(red: 21/255, green: 112/255, blue: 183/255)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.brandNavy.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 16)
    }
    
    private var tabSelector: some View {
        HStack(spacing: 0) {
            tabButton(title: "라인업", index: 0)
            tabButton(title: "타임라인", index: 1)
            tabButton(title: "상세 스탯", index: 2)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
    
    private func tabButton(title: String, index: Int) -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                selectedTab = index
            }
        }) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(selectedTab == index ? Color.brandNavy : .gray)
                
                Rectangle()
                    .fill(selectedTab == index ? Color.brandNavy : Color.clear)
                    .frame(height: 3)
                    .cornerRadius(1.5)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var lineupsView: some View {
        VStack(spacing: 16) {
            if let lineups = viewModel.fixtureDetails?.lineups, lineups.count == 2 {
                HStack(alignment: .top, spacing: 16) {
                    teamLineupView(lineup: lineups[0], isHome: true)
                    teamLineupView(lineup: lineups[1], isHome: false)
                }
                .padding(.horizontal, 16)
            } else {
                emptyStateView(message: "라인업 정보가 없습니다.")
            }
        }
    }
    
    private func teamLineupView(lineup: FixtureLineup, isHome: Bool) -> some View {
        VStack(alignment: isHome ? .leading : .trailing, spacing: 12) {
            HStack {
                if !isHome { Spacer() }
                Text(lineup.formation ?? "포메이션 미정")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.brandNavy)
                    .cornerRadius(6)
                if isHome { Spacer() }
            }
            
            VStack(alignment: isHome ? .leading : .trailing, spacing: 8) {
                Text("선발 명단")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.secondary)
                
                if let startXI = lineup.startXI {
                    ForEach(startXI, id: \.player.name) { item in
                        playerRow(player: item.player, isHome: isHome)
                    }
                }
                
                Text("교체 명단")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                
                if let subs = lineup.substitutes {
                    ForEach(subs, id: \.player.name) { item in
                        playerRow(player: item.player, isHome: isHome)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: isHome ? .leading : .trailing)
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
    }
    
    private func playerRow(player: LineupPlayer, isHome: Bool) -> some View {
        HStack(spacing: 8) {
            if !isHome {
                Text(KoreanTranslationService.translatePlayer(player.name))
                    .font(.system(size: 13, weight: .medium))
                
                Text("\(player.number ?? 0)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(width: 20, alignment: .trailing)
            } else {
                Text("\(player.number ?? 0)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(width: 20, alignment: .leading)
                
                Text(KoreanTranslationService.translatePlayer(player.name))
                    .font(.system(size: 13, weight: .medium))
            }
        }
    }
    
    private var eventsView: some View {
        VStack(spacing: 12) {
            if let events = viewModel.fixtureDetails?.events, !events.isEmpty {
                ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                    HStack {
                        let isHome = event.team.name == viewModel.match.homeTeam
                        
                        if !isHome { Spacer() }
                        
                        HStack(spacing: 8) {
                            Text("\(event.time.elapsed)'")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                            
                            VStack(alignment: isHome ? .leading : .trailing) {
                                Text(KoreanTranslationService.translatePlayer(event.player.name ?? ""))
                                    .font(.system(size: 14, weight: .bold))
                                
                                Text("\(event.type) - \(event.detail)")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
                        
                        if isHome { Spacer() }
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView(message: "이벤트 정보가 없습니다.")
            }
        }
    }
    
    private var statsView: some View {
        VStack(spacing: 12) {
            if let stats = viewModel.fixtureDetails?.statistics, stats.count == 2 {
                let homeStats = stats[0].statistics
                let awayStats = stats[1].statistics
                
                ForEach(0..<min(homeStats.count, awayStats.count), id: \.self) { i in
                    let hStat = homeStats[i]
                    let aStat = awayStats[i]
                    
                    VStack(spacing: 6) {
                        Text(hStat.type)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text(extractValue(hStat.value))
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                                .frame(width: 50, alignment: .leading)
                            
                            Spacer()
                            
                            // Bar visualization could go here
                            
                            Text(extractValue(aStat.value))
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 21/255, green: 112/255, blue: 183/255))
                                .frame(width: 50, alignment: .trailing)
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView(message: "상세 스탯 정보가 없습니다.")
            }
        }
    }
    
    private func extractValue(_ val: StatValue?) -> String {
        switch val {
        case .int(let v): return "\(v)"
        case .string(let v): return v
        default: return "0"
        }
    }
    
    private func emptyStateView(message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.bubble")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.4))
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.top, 40)
    }
}
