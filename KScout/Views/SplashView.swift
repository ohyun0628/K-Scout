import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.4
    
    var body: some View {
        if isActive {
            // 2초 뒤에 메인 탭 뷰로 전환
            MainTabView()
        } else {
            VStack {
                VStack(spacing: 20) {
                    Text("⚽")
                        .font(.system(size: 80))
                    
                    Text("K-Scout")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.green)
                    
                    Text("K-League Player Stats & Match Schedule")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    // 아이콘과 글자가 서서히 커지며 선명해지는 애니메이션
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white) // 필요시 다크모드 대응 배경색으로 변경 가능
            .onAppear {
                // 2초(2.0) 대기 후 isActive를 true로 변경하여 화면 전환
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
