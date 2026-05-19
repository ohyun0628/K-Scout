import SwiftUI

struct HeaderTitleView: View {
    let title: String
    
    var body: some View {
        HStack {
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
        HeaderTitleView(title: "경기 일정")
            .previewLayout(.sizeThatFits)
    }
}
