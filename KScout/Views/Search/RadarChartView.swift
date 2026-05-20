import SwiftUI

// iOS 14 호환 커스텀 레이더 차트 뷰
struct RadarChartView: View {
    let data: [Double] // 0.0 ~ 1.0 사이의 값 5개 (득점, 도움, 슛, 패스, 수비)
    let maxDataValue: Double = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let chartSize = min(size.width, size.height) - 60
            let chartRadius = chartSize / 2
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            
            ZStack {
                // 1. 오각형 배경 거미줄
                SpiderWebBackgroundView(chartSize: chartSize)
                
                // 2. 방사형 선들
                RadialLinesView(center: center, radius: chartRadius)
                
                // 3. 실제 데이터 영역
                RadarDataAreaView(data: data, chartSize: chartSize)
                
                // 4. 데이터 테두리 선
                RadarDataBorderView(data: data, chartSize: chartSize)
                
                // 5. 능력치 라벨 표시
                VertexLabelsView(center: center, radius: chartRadius)
            }
        }
    }
}

// 1. 배경 거미줄 그리기 구조체 분리
struct SpiderWebBackgroundView: View {
    let chartSize: CGFloat
    
    var body: some View {
        ForEach(1...5, id: \.self) { step in
            PolygonShape(sides: 5, scale: CGFloat(step) / 5.0)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .frame(width: chartSize, height: chartSize)
        }
    }
}

// 2. 방사형 선 그리기 구조체 분리
struct RadialLinesView: View {
    let center: CGPoint
    let radius: CGFloat
    
    var body: some View {
        RadialLinesShape(center: center, radius: radius)
            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
    }
}

// 3. 실제 데이터 영역 구조체 분리
struct RadarDataAreaView: View {
    let data: [Double]
    let chartSize: CGFloat
    
    var body: some View {
        RadarDataShape(data: data, sides: 5)
            .fill(Color.brandSecondary.opacity(0.45))
            .frame(width: chartSize, height: chartSize)
            .animation(.easeInOut(duration: 1.0))
    }
}

// 4. 데이터 테두리 선 구조체 분리
struct RadarDataBorderView: View {
    let data: [Double]
    let chartSize: CGFloat
    
    var body: some View {
        RadarDataShape(data: data, sides: 5)
            .stroke(Color.brandLightNavy, lineWidth: 2)
            .frame(width: chartSize, height: chartSize)
            .animation(.easeInOut(duration: 1.0))
    }
}

// 5. 능력치 라벨 표시 구조체 분리
struct VertexLabelsView: View {
    let center: CGPoint
    let radius: CGFloat
    let labels = ["득점", "도움", "슈팅", "패스", "수비"]
    
    var body: some View {
        ForEach(0..<5, id: \.self) { i in
            Text(labels[i])
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color.brandNavy.opacity(0.8))
                .position(labelPosition(index: i, center: center, radius: radius))
        }
    }
    
    private func labelPosition(index: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = CGFloat(index) * (2.0 * .pi / 5.0) - (.pi / 2.0)
        let labelRadius = radius + 18
        let labelX = center.x + labelRadius * cos(angle)
        let labelY = center.y + labelRadius * sin(angle)
        return CGPoint(x: labelX, y: labelY)
    }
}

// 방사형 선들을 그리는 Shape
struct RadialLinesShape: Shape {
    let center: CGPoint
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for i in 0..<5 {
            let angle = CGFloat(i) * (2.0 * .pi / 5.0) - (.pi / 2.0)
            path.move(to: center)
            path.addLine(to: CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            ))
        }
        return path
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
