import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            StandingsView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("순위")
                }
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("일정")
                }
            
            PlayerCompareView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("선수 비교")
                }
        }
        .accentColor(.green) // K리그 연상 색상
    }
}

#Preview {
    MainTabView()
}
