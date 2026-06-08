import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var isErrorText = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        // 1. 로고 및 플랫폼 타이틀 영역
                        VStack(spacing: 12) {
                            Image("SplashIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 85, height: 85)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
                            
                            Text("K-SCOUT")
                                .font(.system(size: 26, weight: .black, design: .default))
                                .foregroundColor(.brandNavy)
                            
                            Text("K리그 데이터 분석 플랫폼")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 40)
                        
                        // 2. 타이틀 헤더 영역 (좌측 정렬)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("안녕하세요 👋")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.brandNavy)
                            
                            Text("계속하려면 로그인하세요")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 15)
                        
                        // 3. 입력 폼 영역
                        VStack(spacing: 14) {
                            TextField("이메일 주소", text: $email)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            HStack {
                                if isPasswordVisible {
                                    TextField("비밀번호", text: $password)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("비밀번호", text: $password)
                                }
                                
                                Button(action: { isPasswordVisible.toggle() }) {
                                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.errorMessage = "비밀번호 찾기 기능은 아직 준비 중입니다."
                                    self.isErrorText = false
                                    self.showError = true
                                }) {
                                    Text("비밀번호 찾기")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.top, 2)
                        }
                        .padding(.horizontal, 24)
                        
                        // 4. 에러 또는 안내 메시지 표시
                        if showError {
                            Text(errorMessage)
                                .foregroundColor(isErrorText ? .red : .brandLightNavy)
                                .font(.footnote)
                                .padding(.horizontal, 24)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // 5. 로그인 버튼
                        Button(action: {
                            handleLogin()
                        }) {
                            Text("로그인")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.brandNavy)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 5)
                        
                        // 6. '또는' 구분선
                        HStack {
                            VStack { Divider().background(Color.gray.opacity(0.3)) }
                            Text("또는")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                            VStack { Divider().background(Color.gray.opacity(0.3)) }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 5)
                        
                        // 7. 소셜 로그인 버튼들
                        VStack(spacing: 12) {
                            Button(action: {
                                self.errorMessage = "구글 소셜 로그인은 다음 단계에서 연동될 예정입니다."
                                self.isErrorText = false
                                self.showError = true
                            }) {
                                HStack(spacing: 10) {
                                    Text("G")
                                        .font(.system(size: 18, weight: .black))
                                        .foregroundColor(.blue)
                                    
                                    Text("Google로 계속하기")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                            
                            Button(action: {
                                self.errorMessage = "애플 소셜 로그인은 다음 단계에서 연동될 예정입니다."
                                self.isErrorText = false
                                self.showError = true
                            }) {
                                HStack(spacing: 10) {
                                    Image(systemName: "applelogo")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    
                                    Text("Apple로 계속하기")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // 8. 하단 회원가입 이동 링크 (NavigationLink 사용)
                        NavigationLink(destination: SignUpView()) {
                            HStack(spacing: 5) {
                                Text("아직 계정이 없으신가요?")
                                    .foregroundColor(.gray)
                                Text("회원가입")
                                    .fontWeight(.bold)
                                    .foregroundColor(.brandNavy)
                            }
                            .font(.footnote)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleLogin() {
        guard !email.isEmpty else {
            self.errorMessage = "이메일을 입력해주세요."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        guard !password.isEmpty else {
            self.errorMessage = "비밀번호를 입력해주세요."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isErrorText = true
                self.showError = true
                return
            }
            authManager.checkLoginState()
        }
    }
}
