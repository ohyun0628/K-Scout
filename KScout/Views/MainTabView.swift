import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            
            RankingView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("순위")
                }
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("일정")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이페이지")
                }
        }
        .accentColor(.green)
    }
}
