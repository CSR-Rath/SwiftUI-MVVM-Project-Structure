//
//  CircleCompassView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 2/2/26.
//

import SwiftUI

struct CompassCircleLineGroupView: View {
    let degree: Double
    let numberOfLines: Int
    let lineSize: CGFloat
    let lineColor: Color
    let lineWidth: CGFloat
    var sizeClear: CGFloat = 0
    
    var body: some View {
        ForEach(0..<numberOfLines, id: \.self) { i in
            Rectangle()
                .fill(lineColor)
                .frame(width: lineWidth, height: lineSize)
                .mask(
                    ZStack {
                        Rectangle()
                        Circle()
                            .frame(width: sizeClear, height: sizeClear)
                            .blendMode(.destinationOut)
                    }
                )
                .rotationEffect(.degrees(Double(i) * degree))
        }
    }
    
}

struct CircleCompassView: View {
    private let size: CGFloat = 340
    
    var body: some View {
        ZStack {
            
            ForEach([340, 280, 220, 160, 80], id: \.self) { s in
                Circle()
                    .stroke(Color.purple.opacity(0.3), lineWidth: 1)
                    .frame(width: s, height: s)
            }
            
            // Green sector
            SectorShape(
                startAngle: .degrees(0),
                endAngle: .degrees(270),
                innerRadius: 220/2,
                outerRadius: 160/2
            )
            .fill(Color.green.opacity(0.7))
            
            
            CompassCircleLineGroupView(
                degree: 15,
                numberOfLines: 24,
                lineSize: size,
                lineColor: Color.purple.opacity(0.3),
                lineWidth: 1
            )
        }
        .frame(width: size, height: size)
    }
}


struct SectorShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(
            x: rect.width / 2,
            y: rect.height / 2
        )
        
        var path = Path()
        
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: max(innerRadius, 0.1),
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        
        path.closeSubpath()
        return path
    }
}
