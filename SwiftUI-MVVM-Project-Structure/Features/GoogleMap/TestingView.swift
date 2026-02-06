//
//  TestingView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 30/1/26.
//

import SwiftUI
import CoreLocation

enum CompassDisplayMode {
    case none
    case compass
    case centerMarker
    case fullLinesCompass
}

struct CompassCircleStyle: Identifiable {
    let id = UUID()
    let size: CGFloat
    let color: Color
    let lineWidth: CGFloat
}







struct InnerCompassDataCenterListView: View {
    
    var heading: Double
    var plus: Double
    let sectors: [SectorData] = [
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 1,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isWater: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 2,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isWater: true, isMountain: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 3,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isMountain: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 4,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isWater: true, isMountain: true, isFire: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 5,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isFire: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 6,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isWater: true, isMountain: true, isFire: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 7,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isWater: true, isMountain: true
        ),
        SectorData(
            starLeft: 1, starRight: 1, starCenter: 8,
            leftColor: .black, rightColor: .black, centerColor: .black,
            isMountain: true
        )
    ]
    
    var body: some View {
        ZStack {
            ForEach(sectors.indices, id: \.self) { i in
                let angle = (Double(i) * 45) + plus
                
                InnerCompassDataCenterView(
                    degree: angle,
                    heading: heading,
                    sector: sectors[i]
                )
            }
        }
    }
}


struct InnerCompassDataCenterView: View {
    var degree: Double
    var heading: Double
    let sector: SectorData
    let radius: CGFloat = 100
    
    var body: some View {
        
        VStack(spacing: 4) {
            
            Text("1")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.green)
                .rotationEffect(.degrees(heading - degree))
            
            Spacer()
            
        }
        .rotationEffect(.degrees(degree))
    }
}
