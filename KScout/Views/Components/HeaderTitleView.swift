import SwiftUI

struct HeaderTitleView: View {
    let title: String
    var showBackButton: Bool = false
    var onBackTap: (() -> Void)? = nil
    
    // 시즌 선택 바인딩 추가 (옵셔널)
    var selectedSeason: Binding<Int>? = nil
    let seasons = [2026, 2025, 2024, 2023, 2022]
    
    var body: some View {
        HStack(spacing: 12) {
            if showBackButton {
                Button(action: {
                    onBackTap?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.brandNavy)
                }
            }
            
            Text(title)
                .font(.system(size: 28, weight: .black))
                .foregroundColor(Color.brandNavy)
            
            Spacer()
            
            if let selectedSeason = selectedSeason {
                Menu {
                    ForEach(seasons, id: \.self) { season in
                        Button(action: {
                            selectedSeason.wrappedValue = season
                        }) {
                            HStack {
                                Text("\(String(season)) 시즌")
                                if selectedSeason.wrappedValue == season {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("\(String(selectedSeason.wrappedValue))년")
                            .font(.system(size: 14, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.brandNavy)
                    .cornerRadius(20)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
}

struct HeaderTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTitleView(title: "경기 일정", selectedSeason: .constant(2026))
            .previewLayout(.sizeThatFits)
    }
}
