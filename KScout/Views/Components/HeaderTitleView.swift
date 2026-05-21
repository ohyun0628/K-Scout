import SwiftUI

struct HeaderTitleView: View {
    let title: String
    var showBackButton: Bool = false
    var onBackTap: (() -> Void)? = nil
    
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
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
}

struct HeaderTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTitleView(title: "경기 일정", showBackButton: true)
            .previewLayout(.sizeThatFits)
    }
}
