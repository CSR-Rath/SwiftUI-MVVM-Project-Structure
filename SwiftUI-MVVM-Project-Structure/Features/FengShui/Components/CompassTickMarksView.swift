//
//  CompassTickMarksView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 6/2/26.
//

import SwiftUI

struct CompassTickMarksView: View {
    var body: some View {
        ZStack {
            ForEach(0..<48) { index in
                let degree = Double(index) * 7.5
                let isLong = degree.truncatingRemainder(dividingBy: 15) == 0
                
                CompassTickShape(isLong: isLong)
                    .stroke(
                        isLong ? Color.black : Color.gray,
                        lineWidth: isLong ? 1.5 : 1
                    )
                    .rotationEffect(.degrees(degree))
            }
        }
    }
}

struct CompassTickShape: Shape {
    var isLong: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(
            to: CGPoint(
                x: rect.midX,
                y: rect.minY + (isLong ? 15 : 8)
            )
        )
        return path
    }
}
