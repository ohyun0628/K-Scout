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
            let targetDateString = "\(String(viewModel.selectedSeason))-\(monthStr)-\(dayStr)"
            
            if let matchDate = match.dateString {
                return matchDate == targetDateString
            }
            
            return false
        }
    }
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드 (#F2F4F7과 유사한 색상)
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 네이버 스포츠 스타일 중앙 정렬 헤더
                ScheduleHeaderView(
                    selectedYear: $viewModel.selectedSeason,
                    selectedMonth: $viewModel.selectedMonth,
                    selectedDay: $viewModel.selectedDay,
                    matches: viewModel.matches
                )
                
                // 2. 무한 가로 데이트 슬라이더 (파란색 밑줄 스타일)
                DateSliderView(
                    selectedYear: $viewModel.selectedSeason,
                    selectedMonth: $viewModel.selectedMonth,
                    selectedDay: $viewModel.selectedDay
                )
                
                // 3. K리그1 / K리그2 세그먼트 셀렉터 (간격 조정)
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
                .padding(.top, 16)
                .padding(.bottom, 12)
                
                // 4. 경기 카드 리스트 영역
                ScrollView(showsIndicators: false) {
                    if viewModel.isLoading {
                        VStack(spacing: 12) {
                            Spacer()
                            ProgressView("경기 일정을 가져오는 중...")
                                .padding(.top, 60)
                            Spacer()
                        }
                    } else if viewModel.selectedSeason >= 2025 && filteredMatches.isEmpty {
                        // 2026시즌 등 미래의 일정이 없을 경우
                        VStack(spacing: 20) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.8))
                                .padding(.top, 60)
                            
                            Text("\(String(viewModel.selectedSeason)) 시즌 경기 일정 준비중입니다.")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.brandNavy)
                            
                            Text("22~24년도만 제공중입니다")
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
                                NavigationLink(destination: MatchDetailView(match: match)) {
                                    MatchCardView(
                                        match: match,
                                        isSubscribed: notificationSubscription.contains(match.id),
                                        onNotificationToggle: {
                                            toggleNotification(for: match)
                                        }
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
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

// MARK: - 네이버 스포츠 스타일 중앙 정렬 헤더
struct ScheduleHeaderView: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int
    var matches: [MockMatch]
    
    @State private var showDatePicker = false
    
    var body: some View {
        HStack {
            // 최근 버튼
            Button(action: {
                let date = Date()
                let calendar = Calendar.current
                selectedYear = calendar.component(.year, from: date)
                selectedMonth = calendar.component(.month, from: date)
                selectedDay = calendar.component(.day, from: date)
            }) {
                Text("최근")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            Spacer()
            
            // 중앙 연/월 텍스트 및 좌우 화살표
            HStack(spacing: 16) {
                Button(action: {
                    if selectedMonth == 1 {
                        if selectedYear > 2022 {
                            selectedYear -= 1
                            selectedMonth = 12
                        }
                    } else {
                        selectedMonth -= 1
                    }
                    selectedDay = 1
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Text(String(format: "%d.%02d", selectedYear, selectedMonth))
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundColor(.black)
                
                Button(action: {
                    if selectedMonth == 12 {
                        selectedYear += 1
                        selectedMonth = 1
                    } else {
                        selectedMonth += 1
                    }
                    selectedDay = 1
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            // 달력 아이콘 (바텀 시트 띄우기)
            Button(action: {
                showDatePicker = true
            }) {
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                        .font(.system(size: 17))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.top, 2)
                }
                .foregroundColor(.gray)
            }
            .sheet(isPresented: $showDatePicker) {
                CalendarSheetView(selectedYear: $selectedYear, selectedMonth: $selectedMonth, selectedDay: $selectedDay, matches: matches)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 12)
        .background(Color(.systemBackground))
    }
}

// MARK: - 네이버 스포츠 스타일 캘린더 바텀 시트
struct CalendarSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int
    var matches: [MockMatch]
    
    @State private var viewingYear: Int
    @State private var viewingMonth: Int
    
    init(selectedYear: Binding<Int>, selectedMonth: Binding<Int>, selectedDay: Binding<Int>, matches: [MockMatch]) {
        self._selectedYear = selectedYear
        self._selectedMonth = selectedMonth
        self._selectedDay = selectedDay
        self.matches = matches
        self._viewingYear = State(initialValue: selectedYear.wrappedValue)
        self._viewingMonth = State(initialValue: selectedMonth.wrappedValue)
    }
    
    var currentYear: Int { Calendar.current.component(.year, from: Date()) }
    var currentMonth: Int { Calendar.current.component(.month, from: Date()) }
    var currentDay: Int { Calendar.current.component(.day, from: Date()) }
    
    let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    
    struct DayItem: Identifiable {
        let id = UUID()
        let day: Int // 0 means empty slot
    }
    
    var daysInMonth: [DayItem] {
        var days: [DayItem] = []
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = viewingYear
        components.month = viewingMonth
        
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else { return [] }
              
        let firstWeekday = calendar.component(.weekday, from: date)
        
        // 빈 공간 채우기
        for _ in 1..<firstWeekday {
            days.append(DayItem(day: 0))
        }
        
        // 실제 날짜 채우기
        for day in range {
            days.append(DayItem(day: day))
        }
        
        return days
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // 헤더
            HStack {
                Menu {
                    ForEach([2026, 2025, 2024, 2023, 2022], id: \.self) { year in
                        Button("\(String(year))년") { viewingYear = year }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("\(String(viewingYear))년")
                            .font(.system(size: 18, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.black)
                }
                
                Spacer()
                
                HStack(spacing: 24) {
                    Button(action: {
                        if viewingMonth == 1 {
                            if viewingYear > 2022 {
                                viewingYear -= 1
                                viewingMonth = 12
                            }
                        } else {
                            viewingMonth -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    
                    Text("\(viewingMonth)월")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 40)
                    
                    Button(action: {
                        if viewingMonth == 12 {
                            viewingYear += 1
                            viewingMonth = 1
                        } else {
                            viewingMonth += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            
            // 요일
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 10)
            
            // 달력 그리드
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                ForEach(daysInMonth) { item in
                    if item.day == 0 {
                        Text("")
                            .frame(height: 50)
                    } else {
                        let isToday = (viewingYear == currentYear && viewingMonth == currentMonth && item.day == currentDay)
                        let isSelected = (viewingYear == selectedYear && viewingMonth == selectedMonth && item.day == selectedDay)
                        let dateStr = String(format: "%04d-%02d-%02d", viewingYear, viewingMonth, item.day)
                        let count = matches.filter { $0.dateString == dateStr }.count
                        
                        Button(action: {
                            selectedYear = viewingYear
                            selectedMonth = viewingMonth
                            selectedDay = item.day
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            VStack(spacing: 4) {
                                Text(isToday ? "오늘" : "\(item.day)")
                                    .font(.system(size: 16, weight: isToday || isSelected ? .bold : .regular))
                                    .foregroundColor(isSelected ? .white : (isToday ? .blue : .black))
                                
                                if count > 0 {
                                    Text("\(count)")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(isSelected ? .white : Color.brandNavy)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(isSelected ? Color.white.opacity(0.3) : Color.brandNavy.opacity(0.1))
                                        .cornerRadius(4)
                                } else {
                                    Text(" ")
                                        .font(.system(size: 11))
                                        .padding(.vertical, 2)
                                }
                            }
                            .frame(width: 40, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? Color.blue : (isToday ? Color.blue.opacity(0.1) : Color.clear))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isToday && !isSelected ? Color.blue.opacity(0.3) : Color.clear, lineWidth: 1)
                            )
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
    }
}

// MARK: - ScheduleViewModel

class ScheduleViewModel: ObservableObject {
    @Published var matches: [MockMatch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedLeague: Int = 1
    @Published var selectedSeason: Int {
        didSet { fetchSchedule() }
    }
    @Published var selectedMonth: Int
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
        let season = self.selectedSeason

        
        if season == 2025 || MockPlayerService.shared.useMockData {
            self.loadMockData(season: season)
            self.isLoading = false
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var allApiMatches: [MockMatch] = []
        var anyFailure = false
        
        // K리그 1
        dispatchGroup.enter()
        NetworkManager.shared.request(endpoint: .fixtures(league: 1, season: season)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    let mapped = self.mapItemsToMock(items: items, league: 1)
                    allApiMatches.append(contentsOf: mapped)
                case .failure:
                    anyFailure = true
                }
                dispatchGroup.leave()
            }
        }
        
        // K리그 2
        dispatchGroup.enter()
        NetworkManager.shared.request(endpoint: .fixtures(league: 2, season: season)) { (result: Result<[FixtureItem], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    let mapped = self.mapItemsToMock(items: items, league: 2)
                    allApiMatches.append(contentsOf: mapped)
                case .failure:
                    anyFailure = true
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            if anyFailure || allApiMatches.isEmpty {
                self.loadMockData(season: season)
            } else {
                self.matches = allApiMatches
            }
        }
    }
    
    private func mapItemsToMock(items: [FixtureItem], league: Int) -> [MockMatch] {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return items.compactMap { item -> MockMatch? in
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
                apiId: item.fixture.id,
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
    }
    
    private func loadMockData(season: Int) {
        if season == 2026 {
            self.matches = DummyData2026.matches
            return
        } else if season == 2025 {
            self.matches = DummyData2025.matches
            return
        } else if season == 2024 {
            self.matches = DummyData2024.matches
            return
        } else if season == 2023 {
            self.matches = DummyData2023.matches
            return
        } else if season == 2022 {
            self.matches = DummyData2022.matches
            return
        }
        
        var baseMatches: [MockMatch] = []
            let l1 = [
                MockMatch(homeTeam: "전북 현대 모터스", awayTeam: "울산 HD FC", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "전주월드컵경기장", league: 1, dayOffset: 0),
                MockMatch(homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "서울월드컵경기장", league: 1, dayOffset: 0),
                MockMatch(homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원종합운동장", league: 1, dayOffset: 0),
                MockMatch(homeTeam: "광주 FC", awayTeam: "인천 유나이티드", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "광주축구전용구장", league: 1, dayOffset: 1),
                MockMatch(homeTeam: "대구 FC", awayTeam: "제주 유나이티드", homeScore: 0, awayScore: 1, status: "FT", time: "종료", stadium: "DGB대구은행파크", league: 1, dayOffset: 1),
                MockMatch(homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강릉종합운동장", league: 1, dayOffset: -1)
            ]
            let l2 = [
                MockMatch(homeTeam: "수원 삼성", awayTeam: "부천 FC 1995", homeScore: 2, awayScore: 1, status: "FT", time: "종료", stadium: "수원월드컵경기장", league: 2, dayOffset: 0),
                MockMatch(homeTeam: "서울 이랜드", awayTeam: "전남 드래곤즈", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "목동종합운동장", league: 2, dayOffset: 0),
                MockMatch(homeTeam: "부산 아이파크", awayTeam: "충남아산 FC", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "부산아시아드주경기장", league: 2, dayOffset: 0),
                MockMatch(homeTeam: "인천 유나이티드", awayTeam: "김포 FC", homeScore: 1, awayScore: 0, status: "FT", time: "종료", stadium: "인천축구전용경기장", league: 2, dayOffset: 1),
                MockMatch(homeTeam: "천안 시티 FC", awayTeam: "화성 FC", homeScore: 0, awayScore: 0, status: "FT", time: "종료", stadium: "천안종합운동장", league: 2, dayOffset: 1),
                MockMatch(homeTeam: "경남 FC", awayTeam: "안산 그리너스", homeScore: 2, awayScore: 2, status: "FT", time: "종료", stadium: "창원축구센터", league: 2, dayOffset: -1)
            ]
        baseMatches = l1 + l2
        
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
