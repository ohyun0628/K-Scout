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
                                statsView // 전력
                            } else if selectedTab == 1 {
                                lineupsView // 라인업
                            } else {
                                eventsView // 기록
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
            tabButton(title: "전력", index: 0)
            tabButton(title: "라인업", index: 1)
            tabButton(title: "기록", index: 2)
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
        VStack(spacing: 24) {
            if let lineups = viewModel.fixtureDetails?.lineups, lineups.count == 2 {
                let homeLineup = lineups[0]
                let awayLineup = lineups[1]
                
                // Graphical Pitch
                VStack(spacing: 0) {
                    // Away Team (Top Half)
                    teamPitchHalfView(lineup: awayLineup, isTop: true)
                    
                    // Center Line
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 2)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                .frame(width: 60, height: 60)
                        )
                    
                    // Home Team (Bottom Half)
                    teamPitchHalfView(lineup: homeLineup, isTop: false)
                }
                .background(Color(red: 91/255, green: 157/255, blue: 96/255)) // Grass Green
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
                .padding(.horizontal, 16)
                
                // Substitutes
                VStack(spacing: 12) {
                    Text("후보선수")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color.brandNavy)
                    
                    HStack(alignment: .top, spacing: 16) {
                        substitutesColumn(lineup: homeLineup, isHome: true)
                        substitutesColumn(lineup: awayLineup, isHome: false)
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView(message: "라인업 정보가 없습니다.")
            }
        }
    }
    
    private func teamPitchHalfView(lineup: FixtureLineup, isTop: Bool) -> some View {
        VStack(spacing: 0) {
            // Team Header Banner
            HStack {
                Text(lineup.team.name)
                    .font(.system(size: 14, weight: .bold))
                Text(lineup.formation ?? "")
                    .font(.system(size: 13, weight: .medium))
                    .opacity(0.9)
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.15))
            
            // Players
            if let startXI = lineup.startXI {
                let gks = startXI.filter { $0.player.pos == "G" }
                let defs = startXI.filter { $0.player.pos == "D" }
                let mids = startXI.filter { $0.player.pos == "M" }
                let fwds = startXI.filter { $0.player.pos == "F" }
                
                // Calculate spacing based on half pitch height
                VStack(spacing: 20) {
                    if isTop {
                        pitchRow(players: gks)
                        pitchRow(players: defs)
                        pitchRow(players: mids)
                        pitchRow(players: fwds)
                    } else {
                        pitchRow(players: fwds)
                        pitchRow(players: mids)
                        pitchRow(players: defs)
                        pitchRow(players: gks)
                    }
                }
                .padding(.vertical, 20)
            }
        }
    }
    
    private func pitchRow(players: [LineupPlayerInfo]) -> some View {
        HStack(spacing: 0) {
            ForEach(players, id: \.player.name) { item in
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 32, height: 32)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(item.player.number ?? 0)")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white)
                        Text(KoreanTranslationService.translatePlayer(item.player.name))
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                    .frame(width: 50)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func substitutesColumn(lineup: FixtureLineup, isHome: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(lineup.team.name)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.bottom, 4)
            .overlay(
                Rectangle()
                    .fill(isHome ? Color.brandNavy : Color.gray)
                    .frame(height: 2),
                alignment: .bottom
            )
            
            if let subs = lineup.substitutes {
                ForEach(subs, id: \.player.name) { item in
                    HStack(spacing: 8) {
                        Text("\(item.player.number ?? 0)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(isHome ? Color.brandNavy : .gray)
                            .frame(width: 18, alignment: .leading)
                        
                        Text(KoreanTranslationService.translatePlayer(item.player.name))
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
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
