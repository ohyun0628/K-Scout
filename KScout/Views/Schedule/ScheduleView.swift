import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("경기 일정 및 라이브 스코어 화면")
                    .foregroundColor(.secondary)
                
                // TODO: 달력 또는 리스트 형태의 경기 일정 뷰 구현
            }
            .navigationTitle("일정")
        }
    }
}
