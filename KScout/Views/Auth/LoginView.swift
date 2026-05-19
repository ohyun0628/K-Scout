import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var nickname = "" // 닉네임 필드 추가
    @State private var isSignUpMode = false // 로그인 모드인지 회원가입 모드인지 구분
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // 밝은 느낌의 배경색 (연한 회색 바탕에 하얀 입력칸이 돋보이도록)
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // 1. 로고 및 타이틀 영역
                    VStack(spacing: 15) {
                        Image("SplashIcon") // 아까 등록한 앱 내부용 아이콘
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        
                        Text("K-SCOUT")
                            .font(.system(size: 32, weight: .black, design: .default))
                            .foregroundColor(.green)
                        
                        Text(isSignUpMode ? "새로운 계정을 만들어보세요!" : "환영합니다! 이메일로 로그인해주세요.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 20)
                    
                    // 2. 입력 폼 영역
                    VStack(spacing: 15) {
                        if isSignUpMode {
                            TextField("닉네임", text: $nickname)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .autocapitalization(.none)
                        }
                        
                        TextField("이메일 주소", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none) // 첫 글자 대문자 자동변환 방지
                        
                        SecureField("비밀번호", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 30)
                    
                    // 3. 에러 메시지 표시
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal, 30)
                    }
                    
                    // 4. 메인 버튼 (로그인 또는 회원가입)
                    Button(action: {
                        if isSignUpMode {
                            handleSignUp()
                        } else {
                            handleLogin()
                        }
                    }) {
                        Text(isSignUpMode ? "회원가입 하기" : "로그인")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // 5. 모드 전환 링크
                    HStack {
                        Text(isSignUpMode ? "이미 계정이 있으신가요?" : "아직 계정이 없으신가요?")
                            .foregroundColor(.gray)
                        Button(action: {
                            withAnimation {
                                isSignUpMode.toggle()
                                showError = false
                            }
                        }) {
                            Text(isSignUpMode ? "로그인" : "회원가입")
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Firebase Auth Functions
    
    private func handleLogin() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError = true
                return
            }
            // 로그인 성공 시 AuthManager 상태 업데이트
            authManager.checkLoginState()
        }
    }
    
    private func handleSignUp() {
        guard !nickname.isEmpty else {
            self.errorMessage = "닉네임을 입력해주세요."
            self.showError = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError = true
                return
            }
            
            // 회원가입 성공 시 프로필에 닉네임 설정
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = nickname
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("닉네임 설정 에러: \(error.localizedDescription)")
                }
                // 최종 로그인 상태 업데이트
                authManager.checkLoginState()
            }
        }
    }
}
