//
//  CompassLineGroupView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 6/2/26.
//

import SwiftUI

struct CompassLineGroupView: View {
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
