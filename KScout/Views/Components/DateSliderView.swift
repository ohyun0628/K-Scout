import SwiftUI

struct DateSliderView: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int
    
    // 선택된 달의 일수 계산
    var daysInMonth: Int {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        let calendar = Calendar.current
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else { return 30 }
        return range.count
    }
    
    // 특정 일자의 요일 반환
    func weekdayString(for day: Int) -> String {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = day
        if let date = calendar.date(from: components) {
            let weekday = calendar.component(.weekday, from: date)
            let weekdayNames = ["일", "월", "화", "수", "목", "금", "토"]
            return weekdayNames[weekday - 1]
        }
        return ""
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1...daysInMonth, id: \.self) { day in
                        Button(action: {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                selectedDay = day
                            }
                        }) {
                            VStack(spacing: 6) {
                                Text(weekdayString(for: day))
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(selectedDay == day ? Color.brandNavy : .gray)
                                
                                Text("\(day)")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(selectedDay == day ? .white : Color.brandNavy)
                                    .frame(width: 36, height: 36)
                                    .background(selectedDay == day ? Color.brandNavy : Color.clear)
                                    .clipShape(Circle())
                            }
                        }
                        .id(day)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 6)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    proxy.scrollTo(selectedDay, anchor: .center)
                }
            }
            .onChange(of: selectedDay) { newDay in
                withAnimation {
                    proxy.scrollTo(newDay, anchor: .center)
                }
            }
            .onChange(of: selectedMonth) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        proxy.scrollTo(selectedDay, anchor: .center)
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .background(Color.white)
    }
}
