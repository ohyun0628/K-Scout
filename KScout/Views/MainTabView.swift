import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("일정")
                }
            
            RankingView()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("순위")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("선수")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star")
                    Text("즐겨찾기")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("마이")
                }
        }
        .accentColor(.brandNavy) // 브랜드 메인 컬러인 brandNavy로 액센트 컬러 설정
    }
}
