import SwiftUI

// iOS 14 호환 커스텀 레이더 차트 뷰
struct RadarChartView: View {
    let data: [Double] // 0.0 ~ 1.0 사이의 값 5개 (득점, 도움, 슛, 패스, 수비)
    let maxDataValue: Double = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            makeRadar(size: geometry.size)
        }
    }
    
    private func makeRadar(size: CGSize) -> some View {
        let chartSize = min(size.width, size.height) - 60
        let chartRadius = chartSize / 2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let labels = ["득점", "도움", "슈팅", "패스", "수비"]
        
        return ZStack {
            // 1. 배경 오각형 거미줄 그리기
            ForEach(1...5, id: \.self) { step in
                let scale = CGFloat(step) / 5.0
                PolygonShape(sides: 5, scale: scale)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    .frame(width: chartSize, height: chartSize)
            }
            
            // 2. 뻗어나가는 선
            drawLines(center: center, radius: chartRadius)
            
            // 3. 실제 능력치 면적
            RadarDataShape(data: data, sides: 5)
                .fill(Color.brandSecondary.opacity(0.45))
                .frame(width: chartSize, height: chartSize)
                .animation(.easeInOut(duration: 1.0))
            
            RadarDataShape(data: data, sides: 5)
                .stroke(Color.brandLightNavy, lineWidth: 2)
                .frame(width: chartSize, height: chartSize)
                .animation(.easeInOut(duration: 1.0))
            
            // 5. 능력치 라벨 표시
            ForEach(0..<5) { i in
                let angle = CGFloat(i) * (2.0 * .pi / 5.0) - (.pi / 2.0)
                let labelRadius = chartRadius + 18
                let labelX = center.x + labelRadius * cos(angle)
                let labelY = center.y + labelRadius * sin(angle)
                
                Text(labels[i])
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Color.brandNavy.opacity(0.8))
                    .position(x: labelX, y: labelY)
            }
        }
    }
    
    private func drawLines(center: CGPoint, radius: CGFloat) -> some View {
        return ForEach(0..<5) { i in
            let angle: CGFloat = CGFloat(i) * (CGFloat(2.0) * CGFloat.pi / CGFloat(5.0)) - (CGFloat.pi / CGFloat(2.0))
            let endX: CGFloat = center.x + radius * cos(angle)
            let endY: CGFloat = center.y + radius * sin(angle)
            let endPoint = CGPoint(x: endX, y: endY)
            
            Path { path in
                path.move(to: center)
                path.addLine(to: endPoint)
            }
            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        }
    }
}

// 다각형 껍데기를 그리는 구조체
struct PolygonShape: Shape {
    let sides: Int
    let scale: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 * scale
        
        for i in 0..<sides {
            let angle = CGFloat(i) * (2.0 * .pi / CGFloat(sides)) - .pi / 2
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

// 실제 능력치 데이터를 바탕으로 도형을 그리는 구조체
struct RadarDataShape: Shape {
    var data: [Double]
    let sides: Int
    
    var animatableData: [Double] {
        get { data }
        set { data = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        for i in 0..<sides {
            let value = CGFloat(max(0, min(1, data[i % data.count])))
            let angle = CGFloat(i) * (2.0 * .pi / CGFloat(sides)) - .pi / 2
            let point = CGPoint(
                x: center.x + radius * value * cos(angle),
                y: center.y + radius * value * sin(angle)
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}
