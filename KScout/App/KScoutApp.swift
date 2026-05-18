import SwiftUI

@main
struct KScoutApp: App {
    var body: some Scene {
        WindowGroup {
            // 기존 MainTabView() 대신 로딩 화면을 먼저 띄웁니다.
            SplashView()
        }
    }
}
