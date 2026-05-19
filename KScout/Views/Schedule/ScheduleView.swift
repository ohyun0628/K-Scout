import SwiftUI

struct MockMatch: Identifiable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int?
    let awayScore: Int?
    let status: String // "LIVE", "NS" (Not Started), "FT" (Finished)
    let time: String // e.g. "15:00" or "67'"
    let stadium: String
    let league: Int // 1 for K리그1, 2 for K리그2
    let dayOffset: Int // Offset from selected date (e.g. 0 for "목 18", -3 for "월 15")
}

struct ScheduleView: View {
    @State private var selectedLeague = 1 // 1: K리그1, 2: K리그2
    @State private var selectedDayOffset = 0 // Offset from the middle date (0 corresponds to "목 18")
    @State private var notificationSubscription: Set<UUID> = [] // 알림 설정한 경기 목록
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 주간 요일/일자 정의 (레퍼런스 이미지 기준 목 18일이 오늘/기본 선택)
    let dateItems = [
        (dayName: "월", dayNumber: "15", offset: -3),
        (dayName: "화", dayNumber: "16", offset: -2),
        (dayName: "수", dayNumber: "17", offset: -1),
        (dayName: "목", dayNumber: "18", offset: 0),
        (dayName: "금", dayNumber: "19", offset: 1),
        (dayName: "토", dayNumber: "20", offset: 2),
        (dayName: "일", dayNumber: "21", offset: 3)
    ]
    
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
                HStack {
                    Text("경기 일정")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(Color.brandNavy)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
                
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
                
                // 3. 주간 데이트 슬라이더 (Mockup 완벽 매칭)
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        ForEach(dateItems, id: \.offset) { item in
                            Button(action: {
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                    selectedDayOffset = item.offset
                                }
                            }) {
                                VStack(spacing: 8) {
                                    Text(item.dayName)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(selectedDayOffset == item.offset ? Color.brandNavy : .gray)
                                    
                                    Text(item.dayNumber)
                                        .font(.system(size: 15, weight: .black))
                                        .foregroundColor(selectedDayOffset == item.offset ? .white : Color.brandNavy)
                                        .frame(width: 32, height: 32)
                                        .background(selectedDayOffset == item.offset ? Color.brandNavy : Color.clear)
                                        .clipShape(Circle())
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    
                    // 슬라이더 바 스크롤바 형태 데코레이션
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 4)
                        
                        // 현재 선택된 위치에 따라 바 인디케이터 정렬 효과 계산
                        GeometryReader { geo in
                            let step = geo.size.width / 7
                            let index = CGFloat(selectedDayOffset + 3) // offset -3~3 -> index 0~6
                            
                            Capsule()
                                .fill(Color.brandNavy)
                                .frame(width: step - 12, height: 4)
                                .offset(x: index * step + 6)
                        }
                        .frame(height: 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
                .background(Color.white)
                .padding(.bottom, 8)
                
                // 4. 경기 카드 리스트 영역
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
                                matchCardView(match: match)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .navigationBarHidden(true) // 커스텀 헤더 사용하므로 내비게이션 바는 숨김
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("경기 알림 설정"),
                message: Text(alertMessage),
                dismissButton: .default(Text("확인"))
            )
        }
    }
    
    // MARK: - Match Card Subviews
    
    @ViewBuilder
    private func matchCardView(match: MockMatch) -> some View {
        HStack(spacing: 0) {
            // 좌측 상태 인디케이터 컬러 바 (LIVE 경기 시 빨간 바 표출)
            if match.status == "LIVE" {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 4)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                // 상단 매치 뱃지 및 추가 기능 버튼
                HStack {
                    // 경기 상태에 따른 다른 스타일 배지 표출
                    if match.status == "LIVE" {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 6, height: 6)
                            Text("● LIVE \(match.time)")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.red)
                        .cornerRadius(12)
                    } else if match.status == "NS" {
                        Text(match.time)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color.brandNavy)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.brandNavy.opacity(0.3), lineWidth: 1)
                            )
                    } else {
                        Text("종료")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                    
                    // 알림 받기 설정 (경기 시작 전인 경우 알림 아이콘 노출)
                    if match.status == "NS" {
                        Button(action: {
                            toggleNotification(for: match)
                        }) {
                            Image(systemName: notificationSubscription.contains(match.id) ? "bell.fill" : "bell")
                                .font(.system(size: 16))
                                .foregroundColor(notificationSubscription.contains(match.id) ? Color.brandNavy : .gray)
                        }
                    }
                }
                
                // 팀 이름 및 점수 스코어 레이아웃
                HStack {
                    // 홈 팀
                    Text(match.homeTeam)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 스코어 또는 VS 구분선
                    if match.status == "LIVE" || match.status == "FT" {
                        HStack(spacing: 12) {
                            Text("\(match.homeScore ?? 0)")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primary)
                            
                            Text(":")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.gray.opacity(0.6))
                            
                            Text("\(match.awayScore ?? 0)")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primary)
                        }
                        .frame(width: 80)
                    } else {
                        Text("vs")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray.opacity(0.6))
                            .frame(width: 80)
                    }
                    
                    // 어웨이 팀
                    Text(match.awayTeam)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 4)
                
                // 경기장 이름
                HStack {
                    Spacer()
                    Text(match.stadium)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 16)
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
