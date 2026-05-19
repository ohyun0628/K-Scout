import SwiftUI
import FirebaseAuth

struct MyPageView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // 사용자 설정 영구 저장용 AppStorage
    @AppStorage("favoriteClub") private var favoriteClub = "선택 안 함"
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    // UI 제어 상태 변수
    @State private var showClubPicker = false
    @State private var showResetPasswordAlert = false
    @State private var showLogoutAlert = false
    @State private var showDeleteAccountAlert = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    // K리그 주요 구단 목록
    let kLeagueClubs = [
        "선택 안 함",
        "강원 FC", "광주 FC", "김천 상무", "대구 FC", 
        "대전 하나 시티즌", "FC 서울", "수원 FC", "울산 HD FC", 
        "인천 유나이티드", "전북 현대 모터스", "제주 유나이티드", "포항 스틸러스",
        "수원 삼성 블루윙즈", "부산 아이파크", "서울 이랜드 FC", "전남 드래곤즈"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // 부드러운 그레이 백그라운드
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // 1. 프로필 카드 영역 (딥 네이비 프리미엄 패널)
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                // 프로필 이니셜 원형 아바타
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                        .frame(width: 70, height: 70)
                                    
                                    Text(String(authManager.currentUser?.displayName?.prefix(1) ?? "K"))
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(authManager.currentUser?.displayName ?? "K-Scout 회원님")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text(authManager.currentUser?.email ?? "이메일 정보 없음")
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
                        
                        // 2. 단독 관심 선수 대시보드 카드 (NavigationLink로 FavoriteView 연동)
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
                        
                        // 3. 설정 그룹 (선호 구단 / 알림 설정)
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
                        
                        // 4. 일반 지원 그룹 (공지사항 / 고객센터 / 비밀번호 재설정)
                        VStack(spacing: 0) {
                            Button(action: {
                                alertMessage = "공지사항 준비 중입니다."
                                showAlert = true
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
                                alertMessage = "고객센터 준비 중입니다."
                                showAlert = true
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
                                showResetPasswordAlert = true
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
                        
                        // 5. 로그아웃 및 회원 탈퇴 그룹
                        VStack(spacing: 0) {
                            Button(action: {
                                showLogoutAlert = true
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
                                showDeleteAccountAlert = true
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
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
            // 선호 구단 선택용 시트
            .sheet(isPresented: $showClubPicker) {
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
            // 일반 안내 모달
            .alert(isPresented: $showAlert) {
                Alert(title: Text("안내"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
        // 비밀번호 재설정 얼럿
        .alert(isPresented: $showResetPasswordAlert) {
            Alert(
                title: Text("비밀번호 재설정"),
                message: Text("등록된 이메일(\(authManager.currentUser?.email ?? ""))로 비밀번호 재설정 링크를 보내시겠습니까?"),
                primaryButton: .default(Text("보내기"), action: {
                    if let email = authManager.currentUser?.email {
                        Auth.auth().sendPasswordReset(withEmail: email) { error in
                            if let error = error {
                                alertMessage = "오류가 발생했습니다: \(error.localizedDescription)"
                            } else {
                                alertMessage = "비밀번호 재설정 메일이 전송되었습니다."
                            }
                            showAlert = true
                        }
                    }
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        // 로그아웃 얼럿
        .background(
            EmptyView()
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("로그아웃"),
                        message: Text("정말 로그아웃 하시겠습니까?"),
                        primaryButton: .destructive(Text("로그아웃"), action: {
                            authManager.logout()
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
        )
        // 회원 탈퇴 얼럿
        .background(
            EmptyView()
                .alert(isPresented: $showDeleteAccountAlert) {
                    Alert(
                        title: Text("회원 탈퇴"),
                        message: Text("정말 계정을 탈퇴하시겠습니까? 이 작업은 취소할 수 없습니다."),
                        primaryButton: .destructive(Text("탈퇴하기"), action: {
                            authManager.currentUser?.delete { error in
                                if let error = error {
                                    alertMessage = "보안상 재인증이 필요합니다. 다시 로그인 후 시도해주세요. (\(error.localizedDescription))"
                                    showAlert = true
                                } else {
                                    authManager.checkLoginState()
                                }
                            }
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
        )
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
            .environmentObject(AuthManager())
    }
}
