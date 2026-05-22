import SwiftUI

struct DateSliderView: View {
    @Binding var selectedDayOffset: Int
    
    // 현재 날짜를 기준으로 월~일요일 범위 동적 계산 (목요일을 offset 0으로 정렬)
    var dateItems: [(dayName: String, dayNumber: String, offset: Int)] {
        let calendar = Calendar.current
        let today = Date()
        
        let weekday = calendar.component(.weekday, from: today)
        let weekdayNames = ["일", "월", "화", "수", "목", "금", "토"]
        
        // 목요일(5)을 기준점(offset 0)으로 설정
        let daysToThursday = 5 - weekday
        
        return (-3...3).map { offset in
            let targetDate = calendar.date(byAdding: .day, value: daysToThursday + offset, to: today) ?? today
            let dayNum = String(calendar.component(.day, from: targetDate))
            let wday = calendar.component(.weekday, from: targetDate)
            let name = weekdayNames[wday - 1]
            return (dayName: name, dayNumber: dayNum, offset: offset)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                ForEach(dateItems, id: \.offset) { item in
                    Button(action: {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                            selectedDayOffset = item.offset
                        }
                    }) {
                        VStack(spacing: 6) {
                            Text(item.dayName)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(selectedDayOffset == item.offset ? Color.brandNavy : .gray)
                            
                            Text(item.dayNumber)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(selectedDayOffset == item.offset ? .white : Color.brandNavy)
                                .frame(width: 36, height: 36)
                                .background(selectedDayOffset == item.offset ? Color.brandNavy : Color.clear)
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 6)
            
            // 데코레이션 슬라이더 바
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.12))
                    .frame(height: 3)
                
                GeometryReader { geo in
                    let step = geo.size.width / 7
                    let index = CGFloat(selectedDayOffset + 3) // offset -3~3 -> index 0~6
                    
                    Capsule()
                        .fill(Color.brandNavy)
                        .frame(width: step - 16, height: 3)
                        .offset(x: index * step + 8)
                }
                .frame(height: 3)
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 10)
        .background(Color.white)
    }
}

struct DateSliderView_Previews: PreviewProvider {
    static var previews: some View {
        DateSliderView(selectedDayOffset: .constant(0))
    }
}
