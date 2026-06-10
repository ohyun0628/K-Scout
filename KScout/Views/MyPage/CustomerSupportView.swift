import SwiftUI

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct CustomerSupportView: View {
    @State private var expandedFaqId: UUID? = nil
    @State private var showContactAlert = false
    
    let faqs = [
        FAQ(
            question: "나의 관심 선수는 어떻게 추가/해제하나요?",
            answer: "선수 상세 화면 우측 상단의 별(🌟) 마크를 터치하시면 관심 목록에 추가 또는 해제할 수 있습니다. 추가된 선수는 하단의 '즐겨찾기' 탭에서 모아볼 수 있습니다."
        ),
        FAQ(
            question: "선수 스탯의 육각형 레이더 차트는 어떤 지표를 보여주나요?",
            answer: "레이더 차트는 득점, 도움, 슛, 패스, 수비 등 축구의 핵심 5대 지표를 기반으로 합니다. 선수의 강점과 약점을 한눈에 파악할 수 있도록 직관적인 다각형 그래픽으로 제공됩니다."
        ),
        FAQ(
            question: "네트워크(Wi-Fi, 데이터)가 끊겨도 사용할 수 있나요?",
            answer: "네, 완벽하게 지원합니다. K-Scout은 2022년부터 2026년까지의 방대한 데이터를 내부 로컬 데이터베이스(Mock DB)에 탑재하여, 데이터 통신이 원활하지 않은 오프라인 환경에서도 앱이 멈추지 않고 데이터를 제공합니다."
        ),
        FAQ(
            question: "경기 데이터는 언제 업데이트되나요?",
            answer: "실제 라이브 환경에서는 K리그 공식 경기 기록을 바탕으로 경기 종료 후 약 2시간 이내에 자동으로 최신화됩니다. (현재 제공되는 오프라인 데모 모드에서는 내장된 시뮬레이션 데이터를 우선적으로 사용합니다.)"
        )
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // FAQ 리스트
                    VStack(alignment: .leading, spacing: 14) {
                        Text("자주 묻는 질문 (FAQ)")
                            .font(.headline)
                            .foregroundColor(.brandNavy)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        
                        ForEach(faqs) { faq in
                            VStack(alignment: .leading, spacing: 0) {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        if expandedFaqId == faq.id {
                                            expandedFaqId = nil
                                        } else {
                                            expandedFaqId = faq.id
                                        }
                                    }
                                }) {
                                    HStack(alignment: .center, spacing: 12) {
                                        Text("Q")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.brandNavy)
                                        
                                        Text(faq.question)
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.gray)
                                            .rotationEffect(.degrees(expandedFaqId == faq.id ? 90 : 0))
                                    }
                                    .padding()
                                }
                                
                                if expandedFaqId == faq.id {
                                    Divider()
                                        .padding(.horizontal)
                                    
                                    HStack(alignment: .top, spacing: 12) {
                                        Text("A")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.gray)
                                            .opacity(0.8)
                                        
                                        Text(faq.answer)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineSpacing(5)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6).opacity(0.4))
                                }
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
                            .padding(.horizontal, 16)
                        }
                    }
                    
                    // 문의하기 영역
                    VStack(spacing: 16) {
                        Image(systemName: "envelope.open.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.brandNavy)
                        
                        VStack(spacing: 6) {
                            Text("찾으시는 답변이 없으신가요?")
                                .font(.headline)
                                .foregroundColor(.brandNavy)
                            
                            Text("K-Scout 지원팀이 신속히 도와드리겠습니다.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            showContactAlert = true
                        }) {
                            Text("1:1 문의 메일 보내기")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.brandNavy)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 24)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("고객센터")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showContactAlert) {
            Alert(
                title: Text("이메일 문의 안내"),
                message: Text("K-Scout 공식 고객지원 센터 이메일(support@kscout.com)로 문의 사항을 적어 전송해 주시면 24시간 내에 기재하신 주소로 답변드리겠습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

struct CustomerSupportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomerSupportView()
        }
    }
}
