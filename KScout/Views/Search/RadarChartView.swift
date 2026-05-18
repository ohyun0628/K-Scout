import SwiftUI

// iOS 14 호환 커스텀 레이더 차트 뷰
struct RadarChartView: View {
    let data: [Double] // 0.0 ~ 1.0 사이의 값 5개 (득점, 도움, 슛, 패스, 수비)
    let maxDataValue: Double = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2
            
            ZStack {
                // 1. 배경 오각형 거미줄 그리기
                ForEach(1...5, id: \.self) { step in
                    PolygonShape(sides: 5, scale: CGFloat(step) / 5.0)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
                
                // 2. 배경 중심에서 꼭짓점으로 뻗어나가는 선
                ForEach(0..<5) { i in
                    let angle = CGFloat(i) * (2.0 * .pi / 5.0) - .pi / 2
                    Path { path in
                        path.move(to: center)
                        path.addLine(to: CGPoint(
                            x: center.x + radius * cos(angle),
                            y: center.y + radius * sin(angle)
                        ))
                    }
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
                
                // 3. 실제 능력치 색칠 영역
                RadarDataShape(data: data, sides: 5)
                    .fill(Color.green.opacity(0.4))
                    .animation(.easeInOut(duration: 1.0), value: data)
                
                RadarDataShape(data: data, sides: 5)
                    .stroke(Color.green, lineWidth: 2)
                    .animation(.easeInOut(duration: 1.0), value: data)
            }
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
