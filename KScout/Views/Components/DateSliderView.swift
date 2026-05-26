import SwiftUI

struct DateSliderView: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int
    
    var currentYear: Int { Calendar.current.component(.year, from: Date()) }
    var currentMonth: Int { Calendar.current.component(.month, from: Date()) }
    var currentDay: Int { Calendar.current.component(.day, from: Date()) }
    
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
                HStack(spacing: 8) {
                    ForEach(1...daysInMonth, id: \.self) { day in
                        let isToday = (selectedYear == currentYear && selectedMonth == currentMonth && day == currentDay)
                        let isSelected = (selectedDay == day)
                        let activeColor = Color.blue
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                selectedDay = day
                            }
                        }) {
                            VStack(spacing: 8) {
                                Text(isToday ? "오늘" : weekdayString(for: day))
                                    .font(.system(size: 13, weight: isToday ? .bold : .medium))
                                    .foregroundColor(isSelected || isToday ? activeColor : .gray)
                                
                                Text("\(day)")
                                    .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                                    .foregroundColor(isSelected || isToday ? activeColor : .black)
                                
                                Rectangle()
                                    .fill(isSelected ? activeColor : Color.clear)
                                    .frame(height: 3)
                                    .padding(.horizontal, 4)
                            }
                            .frame(width: 44)
                        }
                        .id(day)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .background(Color.white)
            .overlay(
                Divider()
                    .background(Color.gray.opacity(0.2))
                , alignment: .bottom
            )
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
    }
}
