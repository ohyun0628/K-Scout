import SwiftUI

struct DateSliderView: View {
    @Binding var selectedDayOffset: Int
    
    let dateItems = [
        (dayName: "월", dayNumber: "15", offset: -3),
        (dayName: "화", dayNumber: "16", offset: -2),
        (dayName: "수", dayNumber: "17", offset: -1),
        (dayName: "목", dayNumber: "18", offset: 0),
        (dayName: "금", dayNumber: "19", offset: 1),
        (dayName: "토", dayNumber: "20", offset: 2),
        (dayName: "일", dayNumber: "21", offset: 3)
    ]
    
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
            .padding(.bottom, 6) // 여유 간격을 넉넉히 주어 잘리는 현상 방지
            
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
