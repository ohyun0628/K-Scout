import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @State private var selectedLeague = 1 // 1: K리그1, 2: K리그2
    @State private var selectedDayOffset = 0 // Offset from the middle date (0 corresponds to "목 18")
    @State private var notificationSubscription: Set<UUID> = [] // 알림 설정한 경기 목록
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 조건 필터링 경기 데이터
    private var filteredMatches: [MockMatch] {
        viewModel.matches.filter { $0.league == selectedLeague && $0.dayOffset == selectedDayOffset }
    }
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 경기 일정 커스텀 헤더 타이틀 (시즌 선택 바인딩)
                HeaderTitleView(title: "경기 일정", selectedSeason: $viewModel.selectedSeason)
                
                // 2. K리그1 / K리그2 세그먼트 셀렉터
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedLeague = 1
                        }
                    }) {
                        Text("K리그1")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(selectedLeague == 1 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedLeague == 1 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedLeague = 2
                        }
                    }) {
                        Text("K리그2")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(selectedLeague == 2 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedLeague == 2 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .padding(4)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                // 3. 주간 데이트 슬라이더
                DateSliderView(selectedDayOffset: $selectedDayOffset)
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
            viewModel.fetchSchedule(league: selectedLeague, season: viewModel.selectedSeason)
        }
        .onChange(of: selectedLeague) { newLeague in
            viewModel.fetchSchedule(league: newLeague, season: viewModel.selectedSeason)
        }
        .onChange(of: viewModel.selectedSeason) { newSeason in
            viewModel.fetchSchedule(league: selectedLeague, season: newSeason)
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
    @Published var selectedSeason: Int = 2026
    
    private var apiMatches: [FixtureItem] = []
    
    func fetchSchedule(league: Int, season: Int) {
        self.isLoading = true
        self.errorMessage = nil
        
        NetworkManager.shared.request(endpoint: .fixtures(league: league, season: season)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let items):
                    self.apiMatches = items
                    self.mapApiMatchesToMockMatches(league: league, season: season)
                case .failure:
                    self.loadMockData(league: league)
                }
            }
        }
    }
    
    private func mapApiMatchesToMockMatches(league: Int, season: Int) {
        let calendar = Calendar.current
        let today = Date()
        
        let weekday = calendar.component(.weekday, from: today)
        let daysToThursday = 5 - weekday
        
        var offsetDates: [Int: String] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for offset in -3...3 {
            let targetDate = calendar.date(byAdding: .day, value: daysToThursday + offset, to: today) ?? today
            var components = calendar.dateComponents([.year, .month, .day], from: targetDate)
            components.year = season
            if let searchDate = calendar.date(from: components) {
                offsetDates[offset] = dateFormatter.string(from: searchDate)
            }
        }
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        let apiFiltered = apiMatches.compactMap { item -> MockMatch? in
            guard let matchDate = isoFormatter.date(from: item.fixture.date) else { return nil }
            let matchDateString = dateFormatter.string(from: matchDate)
            
            guard let offset = offsetDates.first(where: { $1 == matchDateString })?.key else {
                return nil
            }
            
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
            
            return MockMatch(
                homeTeam: item.teams.home.name,
                awayTeam: item.teams.away.name,
                homeScore: item.goals.home,
                awayScore: item.goals.away,
                status: displayStatus,
                time: displayTime,
                stadium: item.fixture.venue?.name ?? "경기장",
                league: league,
                dayOffset: offset
            )
        }
        
        self.matches = apiFiltered
    }
    
    private func loadMockData(league: Int) {
        self.matches = [
            MockMatch(homeTeam: "전북 현대 모터스", awayTeam: "울산 HD FC", homeScore: 2, awayScore: 1, status: "LIVE", time: "67'", stadium: "전주월드컵경기장", league: league, dayOffset: 0),
            MockMatch(homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: nil, awayScore: nil, status: "NS", time: "15:00", stadium: "서울월드컵경기장", league: league, dayOffset: 0),
            MockMatch(homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원종합운동장", league: league, dayOffset: 0),
            
            MockMatch(homeTeam: "광주 FC", awayTeam: "인천 유나이티드", homeScore: nil, awayScore: nil, status: "NS", time: "19:00", stadium: "광주축구전용구장", league: league, dayOffset: 1),
            MockMatch(homeTeam: "대구 FC", awayTeam: "제주 유나이티드", homeScore: nil, awayScore: nil, status: "NS", time: "19:30", stadium: "DGB대구은행파크", league: league, dayOffset: 1),
            
            MockMatch(homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강릉종합운동장", league: league, dayOffset: -1)
        ]
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
