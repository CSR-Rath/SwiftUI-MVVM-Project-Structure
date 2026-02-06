//
//  TestingView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 30/1/26.
//

import SwiftUI
import CoreLocation
//internal import Combine

enum CompassMode {
    case none
    case compass
    case centerMarker
    case fullLinesCompass
}



struct CommpassApp: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var centerCoordinate: CLLocationCoordinate2D?
    @State private var mode: CompassMode = .none
    
    private let circleColor: Color = Color.purple
    private let circleBig: CGFloat = 340
    private let circleSmall: CGFloat = 80
    private let compassLabel: CGFloat = 325
    private let lineHeight:  CGFloat = 2000
    private let compassNESW: CGFloat = 130
    private let marker: Color = Color.red
    
    
    
    //---- items number 3 ---
    private let numberSizeBig: CGFloat = 280
    private let numberSizeSmall: CGFloat = 23
    private let centerColor: Color = Color.blue
    
    private let circleSizes: [CGFloat] = [340, 80]
    
    
    var body: some View {
        ZStack{
            
            GoogleMapView(
                location: $locationManager.userLocation,
                centerCoordinate: $centerCoordinate
            )
            .ignoresSafeArea()
            
            ZStack {
                ZStack {
                    DegreeTicksView()
                        .frame(width: circleBig, height: circleBig)
                    
                    Numbers(heading: locationManager.degree)
                        .frame(width: compassLabel, height: compassLabel)
                    
                    CompassNESWView(heading: locationManager.degree)
                        .frame(width: compassNESW, height: compassNESW)
                    
                    
                    // number in compass line
                    InnerCompassDataCenterListView(heading: locationManager.degree, plus: 15)
                        .frame(width: numberSizeBig, height:  numberSizeBig)
                    InnerCompassDataCenterListView(heading: locationManager.degree, plus: 30)
                        .frame(width: numberSizeBig, height:  numberSizeBig)
                    InnerCompassDataCenterListView(heading: locationManager.degree, plus: 22.5)
                        .frame(width: numberSizeSmall, height:  numberSizeSmall)
                }
                .opacity(mode == .fullLinesCompass ? 0 : 1)
                
                
                CompassLineGroupView(
                    degree: 45,
                    numberOfLines: 8,
                    lineSize: 800, // ✅ keep 800
                    lineColor: circleColor,
                    lineWidth: 2,
                    sizeClear: mode == .fullLinesCompass ? 0 : circleSmall
                )
                
            }
            .frame(width: circleBig, height: circleBig)
            .rotationEffect(.degrees(-locationManager.degree), anchor: .center)
            .animation(.linear(duration: 0.15), value: locationManager.degree)
            
            
            Group {
                Circle()
                    .stroke(circleColor, lineWidth: 2)
                    .frame(width: circleBig, height: circleBig)
                Circle()
                    .stroke(circleColor, lineWidth: 2)
                    .frame(width: 80, height: 80)
            }
            .opacity(mode == .fullLinesCompass ? 0 : 1)
            
            
            Group {
                Rectangle()
                    .fill(marker)
                    .frame(width: 1, height: 250)
                
                Rectangle()
                    .fill(centerColor)
                    .frame(width: 250, height: 1)
                
                Circle()
                    .fill(marker)
                    .frame(width: 10, height: 10)
            }
            .opacity((mode == .centerMarker || mode == .compass) ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: mode == .centerMarker || mode == .compass)
            
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("TARGET LAT: \(centerCoordinate?.latitude ?? 0, specifier: "%.5f")")
                        Text("TARGET LNG: \(centerCoordinate?.longitude ?? 0, specifier: "%.5f")")
                        Text("HEADING: \(Int(locationManager.degree))°")
                    }
                    .font(.system(.caption, design: .monospaced))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)
                
                Spacer()
                
                HStack(spacing: 12) {
                    
                    BaseButton(title: "Compass") {
                        
                        mode = .compass
                    }
                    
                    BaseButton(title: "Maker") {
                        mode = .centerMarker
                    }
                    
                    BaseButton(title: "Full Lines") {
                        mode = .fullLinesCompass
                    }
                    
                }
                .padding()
                
                HStack(spacing: 12) {
                    BaseButton(title: "Compass") {
                        
                        //                        mode == .compass
                        //
                        //                        mode == .centerMarker
                        //                        mode == .fullLines
                        
                    }
                    
                    BaseButton(title: "CenterLine") {
                        //                        mode == .centerMarker
                        //                        mode == .compass
                        //                        mode == .fullLines
                        
                    }
                    
                    BaseButton(title: "Stars") {
                        //                        mode == .fullLines
                    }
                    
                }
                .padding()
            }
        }
    }
}


struct DegreeTicksView: View {
    var body: some View {
        ZStack {
            ForEach(0..<48) { index in
                let degree = Double(index) * 7.5
                let isLong = degree.truncatingRemainder(dividingBy: 15) == 0 // degrees / 15 = 0 It is long
                
                DegreeTickShape(isLong: isLong)
                    .stroke(lineWidth: isLong ? 1.5 : 1)
                    .rotationEffect(.degrees(degree))
            }
        }
    }
}


struct DegreeTickShape: Shape {
    var isLong: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(
            to: CGPoint(
                x: rect.midX,
                y: rect.minY + (isLong ? 18 : 8)
            )
        )
        return path
    }
}

struct Numbers: View {
    
    var heading: Double
    
    private let labels = [
        "", "N1","", "N2","", "N3", "", "Ne1", "", "Ne2","", "Ne3",
        "", "E1","", "E2","","E3", "", "Se1","", "Se2","", "Se3",
        "", "S1","", "S2","", "S3","", "Sw1","", "Sw2","", "Sw3",
        "", "W1","", "W2","","W3", "", "Nw1","", "Nw2", "","Nw3"
    ]
    
    var body: some View {
        ZStack {
            ForEach(0..<labels.count, id: \.self) { i in
                let angle = Double(i) * 7.5
                TextCircleView(
                    degree: angle,
                    heading: heading,
                    text: labels[i]
                )
            }
        }
    }
}



struct CompassNESWView: View {
    
    var heading: Double
    
    private let labels = [ "N", "E", "S", "W"]
    
    var body: some View {
        ZStack {
            ForEach(0..<labels.count, id: \.self) { i in
                let angle = (Double(i) * 90 ) + 22.5
                TextCircleNESWView(
                    degree: angle,
                    heading: heading,
                    text: labels[i]
                )
            }
        }
    }
}

struct TextCircleNESWView: View {
    var degree: Double
    var heading: Double
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.red)
                .rotationEffect(.degrees(heading - degree))
            
            Spacer()
        }
        .rotationEffect(.degrees(degree)) // position around circle
    }
}

struct TextCircleView: View {
    var degree: Double
    var heading: Double
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 12, weight: .regular))
                .rotationEffect(.degrees(heading - degree))
            
            Spacer()
        }
        .rotationEffect(.degrees(degree)) // position around circle
    }
}



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
