import SwiftUI

struct AnnouncementWriteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // 입력 바인딩 변수
    @State private var title = ""
    @State private var content = ""
    @State private var isImportant = false
    
    // 오류 알럿 제어
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 새 공지 등록 완료 시 콜백 클로저
    var onSave: (Announcement) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 1. 공지 유형 설정 카드
                        VStack(spacing: 0) {
                            Toggle(isOn: $isImportant) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(isImportant ? .red : .gray)
                                        .frame(width: 24)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("중요 공지사항 설정")
                                            .font(.body)
                                            .fontWeight(.bold)
                                        Text("리스트 맨 위에 상단 고정되며 빨간색 배지가 붙습니다.")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding()
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                        // 2. 제목 입력 카드
                        VStack(alignment: .leading, spacing: 8) {
                            Text("제목")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.brandNavy)
                            
                            TextField("공지사항 제목을 입력하세요", text: $title)
                                .font(.body)
                                .padding(.vertical, 4)
                            
                            Divider()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 16)
                        
                        // 3. 내용 입력 카드
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("본문 내용")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.brandNavy)
                                Spacer()
                                Text("\(content.count)자")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            TextEditor(text: $content)
                                .font(.body)
                                .frame(minHeight: 250)
                                .cornerRadius(8)
                                .padding(.top, 4)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("공지사항 작성")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("취소") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.gray),
                
                trailing: Button("등록") {
                    saveAnnouncement()
                }
                .fontWeight(.bold)
                .foregroundColor(.brandNavy)
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("입력 오류"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
    
    // 공지 유효성 검사 및 저장 처리
    private func saveAnnouncement() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedTitle.isEmpty {
            alertMessage = "공지사항 제목을 입력해 주세요."
            showAlert = true
            return
        }
        
        if trimmedContent.isEmpty {
            alertMessage = "공지사항 내용을 입력해 주세요."
            showAlert = true
            return
        }
        
        // 오늘 날짜 계산 (YYYY.MM.DD 포맷)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: Date())
        
        // 새 공지사항 객체 생성
        let newAnnouncement = Announcement(
            title: trimmedTitle,
            date: dateString,
            content: trimmedContent,
            isImportant: isImportant
        )
        
        // 콜백 실행
        onSave(newAnnouncement)
        
        // 화면 닫기
        presentationMode.wrappedValue.dismiss()
    }
}

struct AnnouncementWriteView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementWriteView(onSave: { _ in })
    }
}
