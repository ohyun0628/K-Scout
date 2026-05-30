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
                let events = viewModel.fixtureDetails?.events ?? []
                VStack(spacing: 0) {
                    // Away Team (Top Half)
                    teamPitchHalfView(lineup: awayLineup, isTop: true, events: events)
                    
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
                    teamPitchHalfView(lineup: homeLineup, isTop: false, events: events)
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
                        substitutesColumn(lineup: homeLineup, isHome: true, events: events)
                        substitutesColumn(lineup: awayLineup, isHome: false, events: events)
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView(message: "라인업 정보가 없습니다.")
            }
        }
    }
    
    private func teamPitchHalfView(lineup: FixtureLineup, isTop: Bool, events: [FixtureEvent]) -> some View {
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
                        pitchRow(players: gks, events: events)
                        pitchRow(players: defs, events: events)
                        pitchRow(players: mids, events: events)
                        pitchRow(players: fwds, events: events)
                    } else {
                        pitchRow(players: fwds, events: events)
                        pitchRow(players: mids, events: events)
                        pitchRow(players: defs, events: events)
                        pitchRow(players: gks, events: events)
                    }
                }
                .padding(.vertical, 20)
            }
        }
    }
    
    private func pitchRow(players: [LineupPlayerInfo], events: [FixtureEvent]) -> some View {
        HStack(spacing: 0) {
            ForEach(players, id: \.player.name) { item in
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 32, height: 32)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                        
                        if let playerId = item.player.id {
                            RemoteImageView(
                                urlString: "https://media.api-sports.io/football/players/\(playerId).png",
                                size: 32,
                                fallback: AnyView(Image(systemName: "person.fill").font(.system(size: 16)).foregroundColor(.gray)),
                                isCircle: true
                            )
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        let playerEvents = events.filter { $0.player.id == item.player.id || $0.assist?.id == item.player.id }
                        let scoredGoal = playerEvents.contains { $0.type.lowercased() == "goal" && $0.player.id == item.player.id }
                        let madeAssist = playerEvents.contains { $0.type.lowercased() == "goal" && $0.assist?.id == item.player.id }
                        let subbedOut = playerEvents.contains { $0.type.lowercased() == "subst" && $0.player.id == item.player.id }
                        
                        if scoredGoal {
                            Text("⚽️")
                                .font(.system(size: 12))
                                .padding(2)
                                .background(Circle().fill(Color.white))
                                .offset(x: -12, y: 12)
                        } else if madeAssist {
                            Text("👟")
                                .font(.system(size: 10))
                                .padding(2)
                                .background(Circle().fill(Color.white))
                                .offset(x: 12, y: -12)
                        }
                        
                        if subbedOut {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(Circle().fill(Color.red))
                                .offset(x: -12, y: -12)
                        }
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
    
    private func substitutesColumn(lineup: FixtureLineup, isHome: Bool, events: [FixtureEvent]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(lineup.team.name)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.bottom, 4)
            .overlay(
                Rectangle()
                    .fill(isHome ? Color(red: 200/255, green: 60/255, blue: 60/255) : Color(red: 60/255, green: 120/255, blue: 230/255))
                    .frame(height: 2),
                alignment: .bottom
            )
            
            if let subs = lineup.substitutes {
                ForEach(subs, id: \.player.name) { item in
                    let subInEvent = events.first { $0.type.lowercased() == "subst" && $0.assist?.id == item.player.id }
                    let isSubbedIn = subInEvent != nil
                    let replacedPlayerName = subInEvent?.player.name
                    let subTime = subInEvent?.time.elapsed
                    let scoredGoal = events.contains { $0.type.lowercased() == "goal" && $0.player.id == item.player.id }
                    
                    HStack(spacing: 12) {
                        // Profile Image with Badge
                        ZStack(alignment: .topLeading) {
                            if let playerId = item.player.id {
                                RemoteImageView(
                                    urlString: "https://media.api-sports.io/football/players/\(playerId).png",
                                    size: 36,
                                    fallback: AnyView(Circle().fill(Color(.systemGray5)).frame(width: 36, height: 36).overlay(Image(systemName: "person.fill").foregroundColor(.gray))),
                                    isCircle: true
                                )
                            } else {
                                Circle().fill(Color(.systemGray5)).frame(width: 36, height: 36)
                                    .overlay(Image(systemName: "person.fill").foregroundColor(.gray))
                            }
                            
                            if isSubbedIn {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .background(Circle().fill(Color(red: 120/255, green: 200/255, blue: 100/255)))
                                    .offset(x: -4, y: -4)
                            }
                        }
                        
                        // Number
                        Text("\(item.player.number ?? 0)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(isHome ? Color(red: 200/255, green: 60/255, blue: 60/255) : Color(red: 60/255, green: 120/255, blue: 230/255))
                            .frame(width: 22, alignment: .center)
                        
                        // Name & Details
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 4) {
                                Text(KoreanTranslationService.translatePlayer(item.player.name))
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.primary)
                                
                                if scoredGoal {
                                    Text("⚽️")
                                        .font(.system(size: 11))
                                }
                            }
                            
                            if isSubbedIn, let replaced = replacedPlayerName, let time = subTime {
                                Text("\(KoreanTranslationService.translatePlayer(replaced)) \(time)'")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
        ScrollView {
            VStack(spacing: 32) {
                // 1. Team Comparison Section
                teamComparisonSection
                
                Divider().background(Color.gray.opacity(0.2))
                
                // 2. Recent Head-to-Head Section
                recentH2HSection
                
                // 3. Top Players Section
                topPlayersSection
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - 1. Team Comparison Section
    private var teamComparisonSection: some View {
        VStack(spacing: 20) {
            // Team Names and Ranks
            HStack(alignment: .top) {
                // Home
                VStack(spacing: 4) {
                    Text(KoreanTranslationService.translateTeam(viewModel.match.homeTeam))
                        .font(.system(size: 18, weight: .bold))
                    if let stand = viewModel.homeStanding {
                        Text("\(stand.rank)위 · \(stand.all.win)승 \(stand.all.draw)무 \(stand.all.lose)패")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 200/255, green: 60/255, blue: 60/255))
                    } else {
                        Text("-위 · -승 -무 -패")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 200/255, green: 60/255, blue: 60/255))
                    }
                }
                .frame(maxWidth: .infinity)
                
                Text("VS")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(Color(white: 0.85))
                    .padding(.horizontal, 8)
                
                // Away
                VStack(spacing: 4) {
                    Text(KoreanTranslationService.translateTeam(viewModel.match.awayTeam))
                        .font(.system(size: 18, weight: .bold))
                    if let stand = viewModel.awayStanding {
                        Text("\(stand.rank)위 · \(stand.all.win)승 \(stand.all.draw)무 \(stand.all.lose)패")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 60/255, green: 120/255, blue: 230/255))
                    } else {
                        Text("-위 · -승 -무 -패")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 60/255, green: 120/255, blue: 230/255))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            // Recent Form
            HStack(alignment: .center) {
                let hForm = viewModel.homeStanding?.form?.map { String($0) } ?? ["-","-","-","-","-"]
                formBoxes(forms: hForm)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("최근경기")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 60, alignment: .center)
                
                let aForm = viewModel.awayStanding?.form?.map { String($0) } ?? ["-","-","-","-","-"]
                formBoxes(forms: aForm)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Average Stats
            VStack(spacing: 12) {
                let hPlayed = Double(viewModel.homeStanding?.all.played ?? 1)
                let aPlayed = Double(viewModel.awayStanding?.all.played ?? 1)
                let hGFor = Double(viewModel.homeStanding?.all.goals?.for ?? 0) / (hPlayed == 0 ? 1 : hPlayed)
                let aGFor = Double(viewModel.awayStanding?.all.goals?.for ?? 0) / (aPlayed == 0 ? 1 : aPlayed)
                let hGAgainst = Double(viewModel.homeStanding?.all.goals?.against ?? 0) / (hPlayed == 0 ? 1 : hPlayed)
                let aGAgainst = Double(viewModel.awayStanding?.all.goals?.against ?? 0) / (aPlayed == 0 ? 1 : aPlayed)
                
                statBarRow(title: "평균득점", homeValue: hGFor, awayValue: aGFor, maxVal: 3.0, homeColor: Color(red: 0.85, green: 0.75, blue: 0.3), awayColor: Color(red: 0.2, green: 0.3, blue: 0.6))
                statBarRow(title: "평균실점", homeValue: hGAgainst, awayValue: aGAgainst, maxVal: 3.0, homeColor: Color(red: 0.85, green: 0.75, blue: 0.3), awayColor: Color(red: 0.2, green: 0.3, blue: 0.6))
            }
            .padding(.top, 8)
        }
    }
    
    private func formBoxes(forms: [String]) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<forms.count, id: \.self) { i in
                let form = forms[i]
                let text = form == "W" ? "승" : (form == "D" ? "무" : "패")
                let color = form == "W" ? Color.green : (form == "D" ? Color.gray : Color.blue)
                
                Text(text)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(color)
                    .frame(width: 22, height: 22)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(color.opacity(0.5), lineWidth: 1))
            }
        }
    }
    
    private func statBarRow(title: String, homeValue: Double, awayValue: Double, maxVal: Double, homeColor: Color, awayColor: Color) -> some View {
        HStack(spacing: 12) {
            // Home Bar
            GeometryReader { geo in
                let width = geo.size.width * CGFloat(homeValue / maxVal)
                RoundedRectangle(cornerRadius: 2)
                    .fill(homeColor)
                    .frame(width: width)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 6)
            
            Text(String(format: "%.2f", homeValue))
                .font(.system(size: 12, weight: .bold))
                .frame(width: 30, alignment: .trailing)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: 60, alignment: .center)
            
            Text(String(format: "%.2f", awayValue))
                .font(.system(size: 12, weight: .bold))
                .frame(width: 30, alignment: .leading)
            
            // Away Bar
            GeometryReader { geo in
                let width = geo.size.width * CGFloat(awayValue / maxVal)
                RoundedRectangle(cornerRadius: 2)
                    .fill(awayColor)
                    .frame(width: width)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 6)
        }
    }
    
    // MARK: - 2. Recent Head-to-Head Section
    private var recentH2HSection: some View {
        VStack(spacing: 16) {
            Text("최근 양팀 맞대결")
                .font(.system(size: 16, weight: .medium))
            
            VStack(spacing: 0) {
                h2hRow(date: "2025/09/27", league: "K리그1", homeTeam: viewModel.match.homeTeam, homeScore: 1, awayScore: 3, awayTeam: viewModel.match.awayTeam, isLast: false)
                h2hRow(date: "2025/07/05", league: "K리그1", homeTeam: viewModel.match.homeTeam, homeScore: 2, awayScore: 3, awayTeam: viewModel.match.awayTeam, isLast: false)
                h2hRow(date: "2025/03/15", league: "K리그1", homeTeam: viewModel.match.awayTeam, homeScore: 0, awayScore: 0, awayTeam: viewModel.match.homeTeam, isLast: true)
            }
        }
    }
    
    private func h2hRow(date: String, league: String, homeTeam: String, homeScore: Int, awayScore: Int, awayTeam: String, isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                // Home
                HStack(spacing: 8) {
                    Text(KoreanTranslationService.translateTeam(homeTeam))
                        .font(.system(size: 13, weight: .medium))
                    TeamLogoView(teamName: homeTeam, size: 24)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // Score & Date
                HStack(spacing: 12) {
                    Text("\(homeScore)")
                        .font(.system(size: 16, weight: .bold))
                    
                    VStack(spacing: 2) {
                        Text(date)
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Text(league)
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 70)
                    
                    Text("\(awayScore)")
                        .font(.system(size: 16, weight: .bold))
                }
                
                // Away
                HStack(spacing: 8) {
                    TeamLogoView(teamName: awayTeam, size: 24)
                    Text(KoreanTranslationService.translateTeam(awayTeam))
                        .font(.system(size: 13, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            
            if !isLast {
                Divider().background(Color.gray.opacity(0.15))
            }
        }
    }
    
    // MARK: - 3. Top Players Section
    private var topPlayersSection: some View {
        VStack(spacing: 16) {
            Text("탑플레이어")
                .font(.system(size: 16, weight: .medium))
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    HStack {
                        Text(KoreanTranslationService.translateTeam(viewModel.match.homeTeam))
                            .font(.system(size: 12, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                        Text("득점").font(.system(size: 11)).foregroundColor(.gray).frame(width: 25)
                        Text("도움").font(.system(size: 11)).foregroundColor(.gray).frame(width: 25)
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        Text(KoreanTranslationService.translateTeam(viewModel.match.awayTeam))
                            .font(.system(size: 12, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                        Text("득점").font(.system(size: 11)).foregroundColor(.gray).frame(width: 25)
                        Text("도움").font(.system(size: 11)).foregroundColor(.gray).frame(width: 25)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 8)
                .overlay(
                    HStack(spacing: 0) {
                        Rectangle().fill(Color(red: 0.85, green: 0.75, blue: 0.3)).frame(height: 2)
                        Rectangle().fill(Color(red: 0.2, green: 0.3, blue: 0.6)).frame(height: 2)
                    },
                    alignment: .top
                )
                .overlay(Divider().background(Color.gray.opacity(0.2)), alignment: .bottom)
                
                // Rows (API Data)
                let limit = max(viewModel.homeTopPlayers.count, viewModel.awayTopPlayers.count, 5)
                ForEach(0..<min(limit, 5), id: \.self) { i in
                    let hPlayer = i < viewModel.homeTopPlayers.count ? viewModel.homeTopPlayers[i] : nil
                    let aPlayer = i < viewModel.awayTopPlayers.count ? viewModel.awayTopPlayers[i] : nil
                    
                    let hName = KoreanTranslationService.translatePlayer(hPlayer?.player.name ?? "-")
                    let hG = hPlayer?.statistics.first?.goals.total ?? 0
                    let hA = hPlayer?.statistics.first?.assists?.total ?? 0
                    
                    let aName = KoreanTranslationService.translatePlayer(aPlayer?.player.name ?? "-")
                    let aG = aPlayer?.statistics.first?.goals.total ?? 0
                    let aA = aPlayer?.statistics.first?.assists?.total ?? 0
                    
                    topPlayerRow(hName: hName, hG: hG, hA: hA, aName: aName, aG: aG, aA: aA)
                }
            }
            
            Text("탑플레이어는 팀 내 공격 포인트가 가장 많은 선수 기준입니다.")
                .font(.system(size: 11))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
    }
    
    private func topPlayerRow(hName: String, hG: Int, hA: Int, aName: String, aG: Int, aA: Int) -> some View {
        HStack {
            // Home
            HStack {
                Text(hName).font(.system(size: 13)).frame(maxWidth: .infinity, alignment: .center).lineLimit(1)
                Text("\(hG)").font(.system(size: 13, weight: .bold)).frame(width: 25, alignment: .center)
                Text("\(hA)").font(.system(size: 13)).foregroundColor(.gray).frame(width: 25, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            // Away
            HStack {
                Text(aName).font(.system(size: 13)).frame(maxWidth: .infinity, alignment: .center).lineLimit(1)
                Text("\(aG)").font(.system(size: 13, weight: .bold)).frame(width: 25, alignment: .center)
                Text("\(aA)").font(.system(size: 13)).foregroundColor(.gray).frame(width: 25, alignment: .center)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 10)
        .overlay(Divider().background(Color.gray.opacity(0.1)), alignment: .bottom)
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
