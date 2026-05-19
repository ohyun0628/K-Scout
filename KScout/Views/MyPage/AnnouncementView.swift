import SwiftUI

struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let content: String
    var isImportant: Bool = false
}

struct AnnouncementView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var expandedId: UUID? = nil
    
    let announcements = [
        Announcement(
            title: "K-Scout 모바일 서비스 정식 출시 안내",
            date: "2026.05.19",
            content: "안녕하세요, K-Scout 관리자입니다.\n\n대한민국 K리그 최고의 축구 데이터를 제공하는 K-Scout 서비스가 정식 출시되었습니다!\n선수 검색, 리그 순위, 경기 일정 조회 및 나만의 관심 선수 리포트 기능까지 다양한 스카우팅 시스템을 경험해 보세요.\n\n앞으로도 더 정교하고 정확한 데이터를 분석하여 제공해 드리겠습니다. 많은 사랑 부탁드립니다. 감사합니다.",
            isImportant: true
        ),
        Announcement(
            title: "[안내] 실시간 K리그2 선수 기록 데이터 연동 지연 해결",
            date: "2026.05.15",
            content: "K리그2 주말 경기 일부 데이터 연동 지연 오류에 대한 복구가 완료되었습니다.\n\n현재 정상적으로 데이터 리포트를 조회하실 수 있으며, 서버의 안정성 확보를 위해 백엔드 모니터링 강도를 높였습니다.\n이용에 불편을 드려 죄송합니다.",
            isImportant: false
        ),
        Announcement(
            title: "선수 가치 산정 모델(KS-Value) 알고리즘 업데이트 공지",
            date: "2026.05.10",
            content: "K-Scout만의 고유 데이터 인덱스인 KS-Value의 평가 알고리즘이 업데이트되었습니다.\n\n공격 지표뿐만 아니라 수비 가담률, 스프린트 횟수, 압박 횟수 등 정교한 수비 공헌 지표의 가중치를 조율하여 수비진 선수들의 평점을 더욱 현실적으로 보정하였습니다.\n자세한 가중치 공식은 순위 탭 가이드를 참고해 주세요.",
            isImportant: false
        )
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(announcements) { announcement in
                        VStack(alignment: .leading, spacing: 0) {
                            // 공지사항 헤더
                            Button(action: {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                    if expandedId == announcement.id {
                                        expandedId = nil
                                    } else {
                                        expandedId = announcement.id
                                    }
                                }
                            }) {
                                HStack(alignment: .top, spacing: 12) {
                                    // 중요 표시 배지
                                    if announcement.isImportant {
                                        Text("중요")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.red)
                                            .cornerRadius(6)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(announcement.title)
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(.brandNavy)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        
                                        Text(announcement.date)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.gray)
                                        .rotationEffect(.degrees(expandedId == announcement.id ? 180 : 0))
                                }
                                .padding()
                            }
                            
                            // 본문 영역 (열렸을 때 활성화)
                            if expandedId == announcement.id {
                                Divider()
                                    .padding(.horizontal)
                                
                                Text(announcement.content)
                                    .font(.subheadline)
                                    .foregroundColor(.primary.opacity(0.8))
                                    .lineSpacing(6)
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
                .padding(.top, 16)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnnouncementView()
        }
    }
}
