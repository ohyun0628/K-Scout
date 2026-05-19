import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25) {
                    // 1. 프로필 카드 영역
                    VStack(spacing: 15) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                            .padding(.top, 10)
                        
                        VStack(spacing: 5) {
                            Text(authManager.currentUser?.displayName ?? "K-Scout 회원님")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(authManager.currentUser?.email ?? "이메일 정보 없음")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 25)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // 2. 간단한 메뉴 목록 (향후 기능 확장용)
                    VStack(spacing: 0) {
                        NavigationLink(destination: Text("설정 화면 준비 중입니다.")) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.green)
                                Text("설정")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                            .padding()
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink(destination: Text("고객센터 준비 중입니다.")) {
                            HStack {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("고객센터")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                            .padding()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // 3. 로그아웃 버튼
                    Button(action: {
                        authManager.logout()
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.doc.on.rect")
                            Text("로그아웃")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.85))
                        .cornerRadius(15)
                        .shadow(color: Color.red.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
            .environmentObject(AuthManager())
    }
}
