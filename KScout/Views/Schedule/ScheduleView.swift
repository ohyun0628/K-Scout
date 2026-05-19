import SwiftUI

struct ScheduleView: View {
    @State private var selectedLeague = 1 // 1: K리그1, 2: K리그2
    @State private var selectedDayOffset = 0 // Offset from the middle date (0 corresponds to "목 18")
    @State private var notificationSubscription: Set<UUID> = [] // 알림 설정한 경기 목록
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 리얼 필드 경기 데이터 목업
    let mockMatches: [MockMatch] = [
        // K리그1 - 목 18일 경기 (목업 이미지 매칭)
        MockMatch(homeTeam: "전북 현대 모터스", awayTeam: "울산 HD FC", homeScore: 2, awayScore: 1, status: "LIVE", time: "67'", stadium: "전주월드컵경기장", league: 1, dayOffset: 0),
        MockMatch(homeTeam: "FC 서울", awayTeam: "포항 스틸러스", homeScore: nil, awayScore: nil, status: "NS", time: "15:00", stadium: "서울월드컵경기장", league: 1, dayOffset: 0),
        MockMatch(homeTeam: "수원 FC", awayTeam: "대전 하나 시티즌", homeScore: 1, awayScore: 1, status: "FT", time: "종료", stadium: "수원종합운동장", league: 1, dayOffset: 0),
        
        // K리그1 - 금 19일 경기
        MockMatch(homeTeam: "광주 FC", awayTeam: "인천 유나이티드", homeScore: nil, awayScore: nil, status: "NS", time: "19:00", stadium: "광주축구전용구장", league: 1, dayOffset: 1),
        MockMatch(homeTeam: "대구 FC", awayTeam: "제주 유나이티드", homeScore: nil, awayScore: nil, status: "NS", time: "19:30", stadium: "DGB대구은행파크", league: 1, dayOffset: 1),
        
        // K리그1 - 수 17일 경기 (과거)
        MockMatch(homeTeam: "강원 FC", awayTeam: "김천 상무", homeScore: 2, awayScore: 0, status: "FT", time: "종료", stadium: "강릉종합운동장", league: 1, dayOffset: -1),
        
        // K리그2 - 목 18일 경기
        MockMatch(homeTeam: "부산 아이파크", awayTeam: "수원 삼성 블루윙즈", homeScore: 0, awayScore: 1, status: "LIVE", time: "82'", stadium: "부산아시아드주경기장", league: 2, dayOffset: 0),
        MockMatch(homeTeam: "서울 이랜드 FC", awayTeam: "전남 드래곤즈", homeScore: nil, awayScore: nil, status: "NS", time: "17:30", stadium: "목동종합운동장", league: 2, dayOffset: 0),
        
        // K리그2 - 토 20일 경기
        MockMatch(homeTeam: "성남 FC", awayTeam: "FC 안양", homeScore: nil, awayScore: nil, status: "NS", time: "14:00", stadium: "탄천종합운동장", league: 2, dayOffset: 2),
        MockMatch(homeTeam: "부천 FC 1995", awayTeam: "충남아산 FC", homeScore: nil, awayScore: nil, status: "NS", time: "16:30", stadium: "부천종합운동장", league: 2, dayOffset: 2)
    ]
    
    // 조건 필터링 경기 데이터
    private var filteredMatches: [MockMatch] {
        mockMatches.filter { $0.league == selectedLeague && $0.dayOffset == selectedDayOffset }
    }
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 경기 일정 커스텀 헤더 타이틀
                HeaderTitleView(title: "경기 일정")
                
                // 2. K리그1 / K리그2 세그먼트 셀렉터 (Mockup 완벽 매칭)
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
                
                // 3. 주간 데이트 슬라이더 (독립 컴포넌트 호출)
                DateSliderView(selectedDayOffset: $selectedDayOffset)
                    .padding(.bottom, 8)
                
                // 4. 경기 카드 리스트 영역 (독립 컴포넌트 호출)
                ScrollView(showsIndicators: false) {
                    if filteredMatches.isEmpty {
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
