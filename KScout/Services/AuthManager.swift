import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    init() {
        // 앱이 켜질 때 로그인 상태 확인
        if let user = Auth.auth().currentUser {
            self.currentUser = user
            self.isLoggedIn = true
        }
    }
    
    func checkLoginState() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
            self.isLoggedIn = true
        } else {
            self.currentUser = nil
            self.isLoggedIn = false
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.currentUser = nil
        } catch {
            print("로그아웃 에러: \(error.localizedDescription)")
        }
    }
}
