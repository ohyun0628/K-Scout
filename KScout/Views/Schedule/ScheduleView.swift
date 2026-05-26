import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @State private var notificationSubscription: Set<UUID> = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 조건 필터링 경기 데이터
    private var filteredMatches: [MockMatch] {
        viewModel.matches.filter { match in
            guard match.league == viewModel.selectedLeague else { return false }
            
            let monthStr = String(format: "%02d", viewModel.selectedMonth)
            let dayStr = String(format: "%02d", viewModel.selectedDay)
            let targetDateString = "\(viewModel.selectedSeason)-\(monthStr)-\(dayStr)"
            
            if let matchDate = match.dateString {
                return matchDate == targetDateString
            }
            
            return false
        }
    }
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 경기 일정 커스텀 헤더 타이틀 (시즌/월 선택 바인딩)
                HeaderTitleView(title: "경기 일정", selectedSeason: $viewModel.selectedSeason, selectedMonth: $viewModel.selectedMonth)
                
                // 2. K리그1 / K리그2 세그먼트 셀렉터
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            viewModel.selectedLeague = 1
                        }
                    }) {
                        Text("K리그1")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(viewModel.selectedLeague == 1 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(viewModel.selectedLeague == 1 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            viewModel.selectedLeague = 2
                        }
                    }) {
                        Text("K리그2")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(viewModel.selectedLeague == 2 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(viewModel.selectedLeague == 2 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .padding(4)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                // 3. 무한 가로 데이트 슬라이더
                DateSliderView(selectedYear: $viewModel.selectedSeason, selectedMonth: $viewModel.selectedMonth, selectedDay: $viewModel.selectedDay)
                    .padding(.bottom, 8)
                
                // 4. 경기 카드 리스트 영역
                ScrollView(showsIndicators: false) {
                    if viewModel.isLoading {
                        VStack(spacing: 12) {
                            Spacer()
                            ProgressView("경기 일정을 가져오는 중...")
                                .padding(.top, 60)
                            Spacer()
                        }
                    } else if viewModel.selectedSeason >= 2026 && filteredMatches.isEmpty {
                        // 2026시즌 등 미래의 일정이 없을 경우
                        VStack(spacing: 20) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.8))
                                .padding(.top, 60)
                            
                            Text("\(viewModel.selectedSeason) 시즌 일정 준비 중")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                            
                            Text("\(viewModel.selectedSeason) 시즌 경기 일정은 준비 중입니다.\n이전 시즌(2025년 이하) 정보를 조회해 주세요.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .lineSpacing(5)
                        }
                        .frame(maxWidth: .infinity)
                    } else if filteredMatches.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "sportscourt")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.6))
                                .padding(.top, 60)
                            
                            Text("해당 날짜에 경기가 없습니다.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    } else {
                        LazyVStack(spacing: 14) {
                            ForEach(filteredMatches) { match in
                                MatchCardView(
                                    match: match,
                                    isSubscribed: notificationSubscription.contains(match.id),
                                    onNotificationToggle: {
                                        toggleNotification(for: match)
                                    }
                                )
                            }
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("경기 알림 설정"),
                message: Text(alertMessage),
                dismissButton: .default(Text("확인"))
            )
        }
        .onAppear {
            viewModel.fetchSchedule()
        }
    }
    
    // 알림 설정 토글 비즈니스 로직
    private func toggleNotification(for match: MockMatch) {
        if notificationSubscription.contains(match.id) {
            notificationSubscription.remove(match.id)
            alertMessage = "\(match.homeTeam) vs \(match.awayTeam) 경기의 알림이 취소되었습니다."
        } else {
            notificationSubscription.insert(match.id)
            alertMessage = "\(match.homeTeam) vs \(match.awayTeam) 경기 시작 15분 전에 푸시 알림을 보내드립니다!"
        }
        showAlert = true
    }
}

// MARK: - ScheduleViewModel

class ScheduleViewModel: ObservableObject {
    @Published var matches: [MockMatch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedLeague: Int = 1 {
        didSet { fetchSchedule() }
    }
    @Published var selectedSeason: Int {
        didSet { fetchSchedule() }
    }
    @Published var selectedMonth: Int {
        didSet { fetchSchedule() }
    }
    @Published var selectedDay: Int
    
    private var apiMatches: [FixtureItem] = []
    
    init() {
        let date = Date()
        let calendar = Calendar.current
        self.selectedSeason = calendar.component(.year, from: date)
        self.selectedMonth = calendar.component(.month, from: date)
        self.selectedDay = calendar.component(.day, from: date)
    }
    
    func fetchSchedule() {
        self.isLoading = true
        self.errorMessage = nil
        let league = self.selectedLeague
        let season = self.selectedSeason
        
        if season >= 2026 {
            self.matches = []
            self.isLoading = false
            return
        }
        
        if season == 2025 {
            self.loadMockData(league: league, season: season)
            self.isLoading = false
            return
        }
        
        NetworkManager.shared.request(endpoint: .fixtures(league: league, season: season)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let items):
                    if items.isEmpty {
                        self.loadMockData(league: league, season: season)
                    } else {
                        self.apiMatches = items
                        self.mapApiMatchesToMockMatches(league: league, season: season)
                    }
                case .failure:
                    self.loadMockData(league: league, season: season)
                }
            }
        }
    }
    
    private func mapApiMatchesToMockMatches(league: Int, season: Int) {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let apiFiltered = apiMatches.compactMap { item -> MockMatch? in
            guard let matchDate = isoFormatter.date(from: item.fixture.date) else { return nil }
            let matchDateString = dateFormatter.string(from: matchDate)
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeString = timeFormatter.string(from: matchDate)
            
            let statusShort = item.fixture.status.short
            var displayStatus = "NS"
            var displayTime = timeString
            
            if ["1H", "2H", "HT", "ET", "P"].contains(statusShort) {
                displayStatus = "LIVE"
                displayTime = item.fixture.status.elapsed.map { "\($0)'" } ?? "LIVE"
            } else if ["FT", "AET", "PEN"].contains(statusShort) {
                displayStatus = "FT"
                displayTime = "종료"
            }
            
            var match = MockMatch(
                homeTeam: KoreanTranslationService.translateTeam(item.teams.home.name),
                awayTeam: KoreanTranslationService.translateTeam(item.teams.away.name),
                homeScore: item.goals.home,
                awayScore: item.goals.away,
                status: displayStatus,
                time: displayTime,
                stadium: item.fixture.venue?.name ?? "경기장",
                league: league,
                dayOffset: 0
            )
            match.dateString = matchDateString
            return match
        }
        
        self.matches = apiFiltered
    }
    
    private func loadMockData(league: Int, season: Int) {
        var baseMatches: [MockMatch] = []
        
        if season == 2025 {
            baseMatches = DummyData2025.matches.filter { $0.league == league }
        } else {
            // 과거 시즌 더미 데이터
            baseMatches = [
                MockMatch(homeTeam: "전북 현대 모터스", awayTeam: "울산 HD FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "전주월드컵경기장", league: league, dayOffset: 0),
                MockMatch(homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "서울월드컵경기장", league: league, dayOffset: 0),
                MockMatch(homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원종합운동장", league: league, dayOffset: 0),
                MockMatch(homeTeam: "광주 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "광주축구전용구장", league: league, dayOffset: 1),
                MockMatch(homeTeam: "대구 FC", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "DGB대구은행파크", league: league, dayOffset: 1),
                MockMatch(homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강릉종합운동장", league: league, dayOffset: -1)
            ]
        }
        
        // 더미 데이터의 dayOffset을 이용해 현재 선택된 년/월에 가짜 dateString을 주입
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self.selectedSeason
        dateComponents.month = self.selectedMonth
        dateComponents.day = self.selectedDay
        let centerDate = calendar.date(from: dateComponents) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let mappedMatches = baseMatches.map { match -> MockMatch in
            var newMatch = match
            let fakeDate = calendar.date(byAdding: .day, value: match.dayOffset, to: centerDate) ?? centerDate
            newMatch.dateString = dateFormatter.string(from: fakeDate)
            return newMatch
        }
        
        self.matches = mappedMatches
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
