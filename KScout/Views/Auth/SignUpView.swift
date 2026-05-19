import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode // 화면 이전을 위한 환경 변수
    
    @State private var nickname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var isNicknameChecked = false
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var isErrorText = true
    
    var body: some View {
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
                            .frame(width: 55, height: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
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
                        Text("회원가입")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.brandNavy)
                        
                        Text("새로운 계정을 만들어보세요")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 15)
                    
                    // 3. 입력 폼 영역
                    VStack(spacing: 14) {
                        // 닉네임 입력 + 중복 확인
                        HStack(spacing: 10) {
                            TextField("닉네임", text: $nickname)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .autocapitalization(.none)
                                .onChange(of: nickname) { _ in
                                    isNicknameChecked = false
                                }
                            
                            Button(action: {
                                checkNicknameUniqueness()
                            }) {
                                Text(isNicknameChecked ? "확인 완료" : "중복 확인")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 16)
                                    .background(isNicknameChecked ? Color.gray : Color.brandNavy)
                                    .cornerRadius(10)
                            }
                            .disabled(isNicknameChecked)
                        }
                        
                        // 이메일 입력
                        TextField("이메일 주소", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        // 비밀번호 입력 (눈 토글)
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
                        
                        // 비밀번호 확인 (눈 토글)
                        HStack {
                            if isConfirmPasswordVisible {
                                TextField("비밀번호 확인", text: $confirmPassword)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("비밀번호 확인", text: $confirmPassword)
                            }
                            
                            Button(action: { isConfirmPasswordVisible.toggle() }) {
                                Image(systemName: isConfirmPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
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
                    
                    // 5. 회원가입 하기 버튼
                    Button(action: {
                        handleSignUp()
                    }) {
                        Text("회원가입 하기")
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
                            .background(Color.white)
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
                        
                        // 8. 하단 로그인 이동 푸터 (dismiss 사용)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // 이전 화면(LoginView)으로 복귀
                        }) {
                            HStack(spacing: 5) {
                                Text("이미 계정이 있으신가요?")
                                    .foregroundColor(.gray)
                                Text("로그인")
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
    
    // MARK: - Sign Up Actions
    
    private func checkNicknameUniqueness() {
        guard !nickname.isEmpty else {
            self.errorMessage = "닉네임을 입력해주세요."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        if nickname.count < 2 {
            self.errorMessage = "닉네임은 2글자 이상이어야 합니다."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        withAnimation {
            self.isNicknameChecked = true
            self.errorMessage = "'\(nickname)'은(는) 사용 가능한 닉네임입니다."
            self.isErrorText = false
            self.showError = true
        }
    }
    
    private func handleSignUp() {
        guard !nickname.isEmpty else {
            self.errorMessage = "닉네임을 입력해주세요."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        guard isNicknameChecked else {
            self.errorMessage = "닉네임 중복 확인을 진행해주세요."
            self.isErrorText = true
            self.showError = true
            return
        }
        
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
        
        guard password == confirmPassword else {
            self.errorMessage = "비밀번호가 일치하지 않습니다."
            self.isErrorText = true
            self.showError = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isErrorText = true
                self.showError = true
                return
            }
            
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = nickname
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("닉네임 설정 에러: \(error.localizedDescription)")
                }
                authManager.checkLoginState()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthManager())
    }
}
