import SwiftUI

struct MatchDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: MatchDetailViewModel
    @State private var selectedTab = 0 // 0: 라인업, 1: 경기 기록, 2: 스탯
    @State private var selectedPlayerId: Int? = nil
    @State private var showPlayerSummary: Bool = false
    
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
                                recordsView // 기록
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
        .sheet(item: $selectedPlayerId) { id in
            PlayerSummarySheet(playerId: id)
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
                Button(action: {
                    if let id = item.player.id {
                        self.selectedPlayerId = id
                        self.showPlayerSummary = true
                    }
                }) {
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
                } // End VStack
                .frame(maxWidth: .infinity)
                } // End Button
                .buttonStyle(PlainButtonStyle())
            } // End ForEach
        } // End HStack
    } // End pitchRow
    
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
                    
                    Button(action: {
                        if let id = item.player.id {
                            self.selectedPlayerId = id
                            self.showPlayerSummary = true
                        }
                    }) {
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
                        } // End VStack
                    } // End HStack
                } // End Button
                .buttonStyle(PlainButtonStyle())
                } // End ForEach
            } // End if let
        } // End VStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
    }
    
    private var recordsView: some View {
        VStack(spacing: 32) {
            matchStatisticsSection
            
            Divider().background(Color.gray.opacity(0.2))
            
            eventsSection
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
    
    private var matchStatisticsSection: some View {
        VStack(spacing: 16) {
            Text("팀 기록")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Header with team names
            HStack {
                Text(KoreanTranslationService.translateTeam(viewModel.match.homeTeam))
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("VS")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(white: 0.8))
                    .padding(.horizontal, 12)
                Text(KoreanTranslationService.translateTeam(viewModel.match.awayTeam))
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 8)
            
            let stats = viewModel.fixtureDetails?.statistics ?? []
            
            let homeStats = stats.first(where: { $0.team.name == viewModel.match.homeTeam })?.statistics ?? []
            let awayStats = stats.first(where: { $0.team.name == viewModel.match.awayTeam })?.statistics ?? []
            
            let targetTypes = [
                ("Ball Possession", "볼 점유율"),
                ("Total Shots", "슈팅"),
                ("Shots on Goal", "유효슈팅"),
                ("Corner Kicks", "코너킥"),
                ("Offsides", "오프사이드"),
                ("Fouls", "파울"),
                ("Yellow Cards", "경고"),
                ("Red Cards", "퇴장")
            ]
            
            ForEach(targetTypes, id: \.0) { typeKey, typeName in
                MatchStatComparisonRow(
                    title: typeName,
                    homeVal: getMatchStatValue(from: homeStats, type: typeKey),
                    awayVal: getMatchStatValue(from: awayStats, type: typeKey)
                )
            }
        }
    }
    
    private func getMatchStatValue(from stats: [StatDetail], type: String) -> String {
        guard let stat = stats.first(where: { $0.type == type }), let value = stat.value else { return "0" }
        switch value {
        case .int(let v): return "\(v)"
        case .string(let s): return s
        case .none: return "0"
        }
    }
    
    private var eventsSection: some View {
        VStack(spacing: 12) {
            Text("주요 이벤트")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            if let events = viewModel.fixtureDetails?.events, !events.isEmpty {
                ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                    HStack {
                        if event.team.name != viewModel.match.homeTeam { Spacer() }
                        
                        HStack(spacing: 8) {
                            Text("\(event.time.elapsed)'")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                            
                            VStack(alignment: event.team.name == viewModel.match.homeTeam ? .leading : .trailing) {
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
                        
                        if event.team.name == viewModel.match.homeTeam { Spacer() }
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                emptyStateView(message: "이벤트 정보가 없습니다.")
            }
        }
    }
    
    private var statsView: some View {
        VStack(spacing: 32) {
            // 1. Team Comparison Section
            teamComparisonSection
            
            Divider().background(Color.gray.opacity(0.2))
            
            // 2. Top Players Section
            topPlayersSection
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 1. Team Comparison Section
    private var teamComparisonSection: some View {
        let hForm = viewModel.homeStanding?.form?.map { String($0) } ?? ["-","-","-","-","-"]
        let aForm = viewModel.awayStanding?.form?.map { String($0) } ?? ["-","-","-","-","-"]
        
        let hGFor = safeAverage(played: viewModel.homeStanding?.all.played, goals: viewModel.homeStanding?.all.goals?.for)
        let aGFor = safeAverage(played: viewModel.awayStanding?.all.played, goals: viewModel.awayStanding?.all.goals?.for)
        let hGAgainst = safeAverage(played: viewModel.homeStanding?.all.played, goals: viewModel.homeStanding?.all.goals?.against)
        let aGAgainst = safeAverage(played: viewModel.awayStanding?.all.played, goals: viewModel.awayStanding?.all.goals?.against)
        
        return VStack(spacing: 20) {
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
                formBoxes(forms: hForm)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("최근경기")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 60, alignment: .center)
                
                formBoxes(forms: aForm)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Average Stats
            VStack(spacing: 12) {
                statBarRow(title: "평균득점", homeValue: hGFor, awayValue: aGFor, maxVal: 3.0, homeColor: Color(red: 0.85, green: 0.75, blue: 0.3), awayColor: Color(red: 0.2, green: 0.3, blue: 0.6))
                statBarRow(title: "평균실점", homeValue: hGAgainst, awayValue: aGAgainst, maxVal: 3.0, homeColor: Color(red: 0.85, green: 0.75, blue: 0.3), awayColor: Color(red: 0.2, green: 0.3, blue: 0.6))
            }
            .padding(.top, 8)
        }
    }
    
    private func safeAverage(played: Int?, goals: Int?) -> Double {
        let p = Double(played ?? 0)
        let g = Double(goals ?? 0)
        if p == 0 { return 0 }
        return g / p
    }
    
    private func formBoxes(forms: [String]) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<forms.count, id: \.self) { i in
                FormBoxView(form: forms[i])
            }
        }
    }
    
    struct FormBoxView: View {
        let form: String
        
        var body: some View {
            let text: String
            let color: Color
            
            if form == "W" {
                text = "승"
                color = Color.green
            } else if form == "D" {
                text = "무"
                color = Color.gray
            } else if form == "L" {
                text = "패"
                color = Color.blue
            } else {
                text = "-"
                color = Color.gray.opacity(0.5)
            }
            
            return Text(text)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(color)
                .frame(width: 22, height: 22)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(color.opacity(0.5), lineWidth: 1))
        }
    }
    
    private func statBarRow(title: String, homeValue: Double, awayValue: Double, maxVal: Double, homeColor: Color, awayColor: Color) -> some View {
        HStack(spacing: 12) {
            // Home Bar
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 2)
                    .fill(homeColor)
                    .frame(width: geo.size.width * CGFloat(homeValue / maxVal))
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
                RoundedRectangle(cornerRadius: 2)
                    .fill(awayColor)
                    .frame(width: geo.size.width * CGFloat(awayValue / maxVal))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 6)
        }
    }
    
    // MARK: - 2. Top Players Section
    private var topPlayersSection: some View {
        let hCount = viewModel.homeTopPlayers.count
        let aCount = viewModel.awayTopPlayers.count
        let maxCount = max(hCount, aCount)
        let limit = min(maxCount, 5)
        
        return VStack(spacing: 16) {
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
                if limit > 0 {
                    ForEach(0..<limit, id: \.self) { i in
                        PlayerRowView(
                            homePlayer: i < hCount ? viewModel.homeTopPlayers[i] : nil,
                            awayPlayer: i < aCount ? viewModel.awayTopPlayers[i] : nil,
                            onPlayerTap: { id in
                                self.selectedPlayerId = id
                                self.showPlayerSummary = true
                            }
                        )
                    }
                } else {
                    topPlayerRow(hName: "-", hG: 0, hA: 0, aName: "-", aG: 0, aA: 0)
                }
            }
            
            Text("탑플레이어는 팀 내 공격 포인트가 가장 많은 선수 기준입니다.")
                .font(.system(size: 11))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
    }
    
    // PlayerRowView to handle let declarations inside ForEach
    struct PlayerRowView: View {
        let homePlayer: PlayerRankingItem?
        let awayPlayer: PlayerRankingItem?
        let onPlayerTap: (Int) -> Void
        
        var body: some View {
            let hName = KoreanTranslationService.translatePlayer(homePlayer?.player.name ?? "-")
            let hG = homePlayer?.statistics.first?.goals.total ?? 0
            let hA = homePlayer?.statistics.first?.assists?.total ?? 0
            
            let aName = KoreanTranslationService.translatePlayer(awayPlayer?.player.name ?? "-")
            let aG = awayPlayer?.statistics.first?.goals.total ?? 0
            let aA = awayPlayer?.statistics.first?.assists?.total ?? 0
            
            return HStack {
                // Home
                Button(action: {
                    if let id = homePlayer?.player.id { onPlayerTap(id) }
                }) {
                    HStack {
                        Text(hName).font(.system(size: 13)).frame(maxWidth: .infinity, alignment: .center).lineLimit(1)
                        Text("\(hG)").font(.system(size: 13, weight: .bold)).frame(width: 25, alignment: .center)
                        Text("\(hA)").font(.system(size: 13)).foregroundColor(.gray).frame(width: 25, alignment: .center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
                
                // Away
                Button(action: {
                    if let id = awayPlayer?.player.id { onPlayerTap(id) }
                }) {
                    HStack {
                        Text(aName).font(.system(size: 13)).frame(maxWidth: .infinity, alignment: .center).lineLimit(1)
                        Text("\(aG)").font(.system(size: 13, weight: .bold)).frame(width: 25, alignment: .center)
                        Text("\(aA)").font(.system(size: 13)).foregroundColor(.gray).frame(width: 25, alignment: .center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical, 10)
            .overlay(Divider().background(Color.gray.opacity(0.1)), alignment: .bottom)
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

struct MatchStatComparisonRow: View {
    let title: String
    let homeVal: String
    let awayVal: String
    
    var body: some View {
        let hStr = homeVal.replacingOccurrences(of: "%", with: "")
        let aStr = awayVal.replacingOccurrences(of: "%", with: "")
        let hNum = Double(hStr) ?? 0
        let aNum = Double(aStr) ?? 0
        let total = (hNum + aNum > 0) ? (hNum + aNum) : 1
        
        let hRatio = hNum / total
        let aRatio = aNum / total
        
        return HStack(spacing: 8) {
            // Home Bar
            HStack(spacing: 8) {
                Text(homeVal)
                    .font(.system(size: 12, weight: .medium))
                    .frame(width: 35, alignment: .trailing)
                
                GeometryReader { geo in
                    ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 2).fill(Color.gray.opacity(0.15))
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(red: 0.85, green: 0.75, blue: 0.3))
                            .frame(width: geo.size.width * CGFloat(hRatio))
                    }
                }
                .frame(height: 6)
            }
            
            // Title
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: 65, alignment: .center)
            
            // Away Bar
            HStack(spacing: 8) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2).fill(Color.gray.opacity(0.15))
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(red: 0.2, green: 0.3, blue: 0.6))
                            .frame(width: geo.size.width * CGFloat(aRatio))
                    }
                }
                .frame(height: 6)
                
                Text(awayVal)
                    .font(.system(size: 12, weight: .medium))
                    .frame(width: 35, alignment: .leading)
            }
        }
        .padding(.vertical, 4)
    }
}
