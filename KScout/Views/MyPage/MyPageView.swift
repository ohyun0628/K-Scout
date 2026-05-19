import SwiftUI
import FirebaseAuth

// 얼럿 타입을 관리하기 위한 열거형
enum MyPageAlert: Identifiable {
    case general(message: String)
    case resetPassword
    case logout
    case deleteAccount
    
    var id: String {
        switch self {
        case .general(let msg): return "general-\(msg)"
        case .resetPassword: return "reset"
        case .logout: return "logout"
        case .deleteAccount: return "delete"
        }
    }
}

struct MyPageView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // 사용자 설정 영구 저장용 AppStorage
    @AppStorage("favoriteClub") private var favoriteClub = "선택 안 함"
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    // UI 제어 상태 변수
    @State private var showClubPicker = false
    @State private var activeAlert: MyPageAlert? = nil
    
    // K리그 주요 구단 목록
    let kLeagueClubs = [
        "선택 안 함",
        "강원 FC", "광주 FC", "김천 상무", "대구 FC", 
        "대전 하나 시티즌", "FC 서울", "수원 FC", "울산 HD FC", 
        "인천 유나이티드", "전북 현대 모터스", "제주 유나이티드", "포항 스틸러스",
        "수원 삼성 블루윙즈", "부산 아이파크", "서울 이랜드 FC", "전남 드래곤즈"
    ]
    
    // MARK: - Computed Properties for Safety (컴파일러 타입 추론 보조)
    
    private var userInitial: String {
        if let name = authManager.currentUser?.displayName, let first = name.first {
            return String(first)
        }
        return "K"
    }
    
    private var userDisplayName: String {
        authManager.currentUser?.displayName ?? "K-Scout 회원님"
    }
    
    private var userEmail: String {
        authManager.currentUser?.email ?? "이메일 정보 없음"
    }
    
    // MARK: - Main Body
    
    var body: some View {
        NavigationView {
            ZStack {
                // 부드러운 그레이 백그라운드 (UIColor 명시로 타입 추론 오류 원천 차단)
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        profileCardSection
                        favoritePlayersSection
                        settingsSection
                        supportSection
                        accountSection
                    }
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
            // 선호 구단 선택용 시트 분리 적용
            .sheet(isPresented: $showClubPicker) {
                clubPickerSheet
            }
            // 단일 얼럿 처리로 컴파일 부하 최적화
            .alert(item: $activeAlert) { alertType in
                makeAlert(for: alertType)
            }
        }
    }
    
    // MARK: - Subviews (컴파일러 성능 최적화)
    
    // 1. 프로필 카드 영역
    private var profileCardSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                // 프로필 이니셜 아바타
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 70, height: 70)
                    
                    Text(userInitial)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(userDisplayName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(userEmail)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    
                    // 선호 구단 배지
                    HStack(spacing: 4) {
                        Image(systemName: "laurel.leading")
                            .font(.caption)
                        Text(favoriteClub)
                            .font(.system(size: 11, weight: .bold))
                        Image(systemName: "laurel.trailing")
                            .font(.caption)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.top, 4)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.brandNavy, Color.brandAccent]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(color: Color.brandNavy.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 16)
        .padding(.top, 15)
    }
    
    // 2. 나의 관심 선수 대시보드 카드
    private var favoritePlayersSection: some View {
        NavigationLink(destination: FavoriteView()) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("나의 관심 선수")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.brandNavy)
                    
                    Text("스카우팅 분석 리포트 바로가기")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text("🌟")
                        .font(.body)
                    Text("12명")
                        .font(.title3)
                        .fontWeight(.black)
                        .foregroundColor(.brandNavy)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray.opacity(0.8))
                        .padding(.leading, 4)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 16)
    }
    
    // 3. 앱 설정 그룹 (선호 구단 / 알림 설정)
    private var settingsSection: some View {
        VStack(spacing: 0) {
            Button(action: {
                showClubPicker.toggle()
            }) {
                HStack {
                    Image(systemName: "shield.fill")
                        .foregroundColor(.brandNavy)
                        .frame(width: 24)
                    Text("선호 구단 설정")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(favoriteClub)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Divider().padding(.horizontal)
            
            Toggle(isOn: $notificationsEnabled) {
                HStack {
                    Image(systemName: "bell.badge.fill")
                        .foregroundColor(.brandNavy)
                        .frame(width: 24)
                    Text("알림 설정")
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: .brandNavy))
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
    }
    
    // 4. 일반 지원 그룹 (공지사항 / 고객센터 / 비밀번호 재설정)
    private var supportSection: some View {
        VStack(spacing: 0) {
            Button(action: {
                activeAlert = .general(message: "공지사항 준비 중입니다.")
            }) {
                HStack {
                    Image(systemName: "megaphone.fill")
                        .foregroundColor(.brandNavy)
                        .frame(width: 24)
                    Text("공지사항")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Divider().padding(.horizontal)
            
            Button(action: {
                activeAlert = .general(message: "고객센터 준비 중입니다.")
            }) {
                HStack {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.brandNavy)
                        .frame(width: 24)
                    Text("고객센터")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Divider().padding(.horizontal)
            
            Button(action: {
                activeAlert = .resetPassword
            }) {
                HStack {
                    Image(systemName: "lock.rotation")
                        .foregroundColor(.brandNavy)
                        .frame(width: 24)
                    Text("비밀번호 재설정")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
    }
    
    // 5. 로그아웃 및 회원 탈퇴 그룹
    private var accountSection: some View {
        VStack(spacing: 0) {
            Button(action: {
                activeAlert = .logout
            }) {
                HStack {
                    Image(systemName: "arrow.right.doc.on.rect")
                        .foregroundColor(.red)
                        .frame(width: 24)
                    Text("로그아웃")
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding()
            }
            
            Divider().padding(.horizontal)
            
            Button(action: {
                activeAlert = .deleteAccount
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.badge.xmark")
                        .foregroundColor(.gray)
                        .frame(width: 24)
                    Text("회원 탈퇴")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }
    
    // 6. 구단 선택용 시트 뷰
    private var clubPickerSheet: some View {
        NavigationView {
            List {
                ForEach(kLeagueClubs, id: \.self) { club in
                    Button(action: {
                        favoriteClub = club
                        showClubPicker = false
                    }) {
                        HStack {
                            Text(club)
                                .foregroundColor(.primary)
                            Spacer()
                            if favoriteClub == club {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.brandNavy)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
            .navigationTitle("선호 구단 선택")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("닫기") {
                showClubPicker = false
            })
        }
    }
    
    // MARK: - Helper Methods for Alerts (컴파일러 부하 경감)
    
    private func makeAlert(for type: MyPageAlert) -> Alert {
        switch type {
        case .general(let message):
            return Alert(
                title: Text("안내"),
                message: Text(message),
                dismissButton: .default(Text("확인"))
            )
        case .resetPassword:
            return Alert(
                title: Text("비밀번호 재설정"),
                message: Text("등록된 이메일(\(userEmail))로 비밀번호 재설정 링크를 보내시겠습니까?"),
                primaryButton: .default(Text("보내기"), action: sendPasswordReset),
                secondaryButton: .cancel(Text("취소"))
            )
        case .logout:
            return Alert(
                title: Text("로그아웃"),
                message: Text("정말 로그아웃 하시겠습니까?"),
                primaryButton: .destructive(Text("로그아웃"), action: authManager.logout),
                secondaryButton: .cancel(Text("취소"))
            )
        case .deleteAccount:
            return Alert(
                title: Text("회원 탈퇴"),
                message: Text("정말 계정을 탈퇴하시겠습니까? 이 작업은 취소할 수 없습니다."),
                primaryButton: .destructive(Text("탈퇴하기"), action: deleteAccount),
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    private func sendPasswordReset() {
        guard let email = authManager.currentUser?.email else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                activeAlert = .general(message: "오류가 발생했습니다: \(error.localizedDescription)")
            } else {
                activeAlert = .general(message: "비밀번호 재설정 메일이 전송되었습니다.")
            }
        }
    }
    
    private func deleteAccount() {
        authManager.currentUser?.delete { error in
            if let error = error {
                activeAlert = .general(message: "보안상 재인증이 필요합니다. 다시 로그인 후 시도해주세요. (\(error.localizedDescription))")
            } else {
                authManager.checkLoginState()
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
            .environmentObject(AuthManager())
    }
}
