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
            question: "로그인 및 회원가입 인증 메일이 오지 않습니다.",
            answer: "메일 발송에 최대 1~3분까지 소요될 수 있습니다. 메일함이 가득 차 있지 않은지 확인하시고, 네이버/구글 등 서비스 제공업체의 정책에 따라 스팸 메일함으로 자동 분류되었을 수 있으니 반드시 스팸함을 확인해 주시기 바랍니다."
        ),
        FAQ(
            question: "나의 관심 선수는 어떻게 해제하나요?",
            answer: "즐겨찾기 탭 또는 선수 상세 화면에서 등록된 선수의 별(🌟) 마크를 해제(터치)하시면 관심 목록에서 즉시 지워집니다."
        ),
        FAQ(
            question: "선수 이적 및 기록 데이터는 언제 업데이트되나요?",
            answer: "K리그 경기 기록 데이터는 공식 연맹 수집 피드를 기반으로 경기 종료 후 대략 2시간 이내에 자동 업데이트됩니다. 이적 시장 정보 및 선수 프로필 변경은 정기 데이터 점검일에 맞춰 동기화됩니다."
        ),
        FAQ(
            question: "K-Scout 데이터 등급 및 산정 방식이 궁금합니다.",
            answer: "K-Scout는 선수의 득점, 도움, 스프린트, 패스 성공률 등 30개 이상의 핵심 스탯을 머신러닝 모델에 대입하여 경기 평점을 책정합니다. 세부 평가 비중은 리그 수준과 포지션에 맞춰 정교하게 가공됩니다."
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
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.brandNavy)
                                        
                                        Text(faq.question)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
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
                                            .font(.title3)
                                            .fontWeight(.bold)
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
                            .background(Color.white)
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
                    .background(Color.white)
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
