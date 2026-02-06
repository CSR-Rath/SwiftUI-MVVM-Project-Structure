//
//  ContentView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
import CoreLocation
internal import Combine



@available(iOS 17.0, *)
struct CompassLines: View {
    @StateObject private var locationManager = LocationManager()
    @State private var centerCoordinate: CLLocationCoordinate2D
    
    @State private var mode: CompassMode = .none
    
    
    
    // UI Constants
    private let centerColor = Color.blue
    private let circleColor = Color.green.opacity(0.7)
    private let circleSizeBig: CGFloat = 320
    private let circleSizeSmall: CGFloat = 80
    
    
    var body: some View {
        ZStack {
            
//            // MARK: - Background Map (ALWAYS alive)
//            GoogleMapView(
//                location: $locationManager.userLocation,
//                centerCoordinate: $centerCoordinate
//            )
//            .ignoresSafeArea()
            
            // MARK: - Compass Overlay
            ZStack {
                
                // Lines
                CompassLineGroup(
                    degree: 7.5,
                    numberOfLines: 48,
                    lineSize: circleSizeBig,
                    lineColor: .black,
                    lineWidth: 1,
                    sizeClear: circleSizeBig - 10
                )
                .opacity(mode == .compass ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass)
                
                
                CompassLineGroup(
                    degree: 15,
                    numberOfLines: 24,
                    lineSize: circleSizeBig,
                    lineColor: .gray,
                    lineWidth: 1,
                    sizeClear: circleSizeBig - 30
                )
                .opacity(mode == .compass ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass)
                
                CompassLineGroup(
                    degree: 45,
                    numberOfLines: 8,
                    lineSize: 600,
                    lineColor: .purple,
                    lineWidth: 1.5,
                    sizeClear: mode == .fullLinesCompass ? 0 : circleSizeSmall
                )
                .opacity((mode == .compass || mode == .fullLinesCompass) ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass || mode == .fullLinesCompass)
                
                
                // Labels 24
                CompassLabels(
                    radius: (circleSizeBig / 2) + 10,
                    heading: locationManager.degree)
                .opacity(mode == .compass ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass)
                
                
                // labels 8 (0, 45, 90, 135, 180,225, 270, 315)
                CompassDirectionDegreeLabels(
                    radius:  (circleSizeBig/2) + 50,
                    heading: locationManager.degree)
                .opacity(mode == .compass ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass)
                
                
                
                // labels (N, E, S, W)
                CompassDirectionLabels(
                    radius: (circleSizeSmall / 2) + 10
                )
                .opacity((mode == .compass || mode == .fullLinesCompass ) ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .compass || mode == .fullLinesCompass)
                
                InnerCompassData(
                    radius: (circleSizeSmall / 2) + 60
                )
                .opacity((mode == .fullLinesCompass ) ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: mode == .fullLinesCompass)
                
                
            }
            .rotationEffect(.degrees(-locationManager.degree))
            //            .opacity(mode == .compass ? 1 : 0)
            //            .animation(.easeInOut(duration: 0.3), value: mode == .compass)
            
            
            //            InnerCompassDataCenter()
            //                .opacity(mode == .compass ? 1 : 0)
            //                .animation(.easeInOut(duration: 0.3), value: mode == .compass)
            
            // MARK: - Circles
            Group {
                Circle()
                    .stroke(.purple, lineWidth: 2)
                    .frame(width: circleSizeBig)
                
                Circle()
                    .stroke(.purple, lineWidth: 2)
                    .frame(width: circleSizeSmall)
            }
            .opacity(mode == .compass ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: mode == .compass)
            
            // MARK: - maker center screen
            Group {
                Rectangle()
                    .fill(centerColor)
                    .frame(width: 1, height: 250)
                
                Rectangle()
                    .fill(centerColor)
                    .frame(width: 250, height: 1)
                
                Circle()
                    .fill(centerColor)
                    .frame(width: 10, height: 10)
            }
            .opacity((mode == .centerMarker || mode == .compass) ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: mode == .centerMarker || mode == .compass)
            
            
            // MARK: - UI Overlay
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
//                        Text("TARGET LAT: \(centerCoordinate?.latitude ?? 0, specifier: "%.5f")")
//                        Text("TARGET LNG: \(centerCoordinate?.longitude ?? 0, specifier: "%.5f")")
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
        .onAppear(){
            
        }
    }
}


// MARK: - Label System
struct CompassLabels: View {
    
    private let labels = ["", "N1","", "N2","", "N3", "", "Ne1", "", "Ne2","", "Ne3",
                          "", "E1","", "E2","","E3", "", "Se1","", "Se2","", "Se3",
                          "", "S1","", "S2","", "S3","", "Sw1","", "Sw2","", "Sw3",
                          "", "W1","", "W2","","W3", "", "Nw1","", "Nw2", "","Nw3"
    ]
    
    let radius: CGFloat
    let heading: Double
    
    var body: some View {
        ForEach(0..<labels.count, id: \.self) { i in
            
            let angle = Double(i) * 7.5
            
            Text(labels[i])
                .background(Color.white.opacity(0.8))
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)
                .shadow(radius: 20)
                .offset(y: -radius)
                .rotationEffect(.degrees(angle))
        }
    }
}


// MARK: - Inner Data Numbers
struct SectorData {
    var starLeft: Int
    var starRight: Int
    var starCenter: Int
    var leftColor: Color
    var rightColor: Color
    var centerColor: Color
    var isWater: Bool = false 
    var isMountain: Bool = false
    var isFire: Bool = false
}


struct InnerCompassData: View {
    let radius: CGFloat
    
    
    var sectors: [SectorData] = [
        
        SectorData(starLeft: 1, starRight: 1, starCenter: 1, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: false, isFire: false),
        SectorData(starLeft: 1, starRight: 1, starCenter: 2, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: true, isFire: false),
        SectorData(starLeft: 1, starRight: 1, starCenter: 3, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: false, isMountain: true, isFire: false),
        SectorData(starLeft: 1, starRight: 1, starCenter: 4, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: true, isFire: true),
        SectorData(starLeft: 1, starRight: 1, starCenter: 5, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: false, isFire: true),
        SectorData(starLeft: 1, starRight: 1, starCenter: 6, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: true, isFire: true),
        SectorData(starLeft: 1, starRight: 1, starCenter: 7, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: true, isFire: true),
        SectorData(starLeft: 1, starRight: 1, starCenter: 8, leftColor: Color.black, rightColor: Color.black, centerColor: Color.black, isWater: true, isMountain: true, isFire: false)
        
    ]
    
    var body: some View {
        ForEach(0..<sectors.count, id: \.self) { i in
            let angle = (Double(i) * 45.0) + 22.5
            let sector = sectors[i]
            
            ZStack {
                VStack(spacing: 0) {
                    
                    let textSize: CGFloat = 14
                    let textWeight: Font.Weight = .regular
                    
                    iconView(
                        systemName: "flame.circle",
                        isVisible: sector.isFire,
                        color: .red
                    )
                    
                    // ⛰ 💧 MIDDLE ICONS
                    HStack(spacing: 12) {
                        iconView(
                            systemName: "triangle.fill",
                            isVisible: sector.isMountain,
                            color: .green
                        )
                        iconView(
                            systemName: "waveform.path.ecg",
                            isVisible: sector.isWater,
                            color: .blue
                        )
                    }
                    
                    // ⭐ LEFT / RIGHT STARS
                    HStack(alignment: .top, spacing: 0) {
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 5, height: 5)
                            .alignmentGuide(.firstTextBaseline) { d in
                                d[VerticalAlignment.firstTextBaseline]
                            }
                        
                        Text("\(sector.starLeft)")
                            .font(.system(size: textSize, weight: textWeight))
                            .foregroundColor(sector.leftColor)
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 5, height: 5)
                        
                        
                        Text("\(sector.starRight)")
                            .font(.system(size: textSize, weight: textWeight))
                            .foregroundColor(sector.rightColor)
                            .padding(.leading, 10)
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 5, height: 5)
                    }
                    
                    Text("\(sector.starCenter)")
                        .font(.system(size: textSize, weight: textWeight))
                        .foregroundColor(sector.centerColor)
                    
                    if sector.isFire == true {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 5, height: 5)
                    }
                    
                }
                
                // Ensures content scales down to fit the sector width
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .frame(width: 70)
                .offset(y: -radius)
                .rotationEffect(.degrees(angle))
            }
        }
    }
    
    @ViewBuilder
    private func iconView(
        systemName: String,
        isVisible: Bool?,
        color: Color
    ) -> some View {
        
        if isVisible == true {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 13, height: 13)
                .foregroundColor(color)
        } else {
            Color.clear
                .frame(width: 13, height: 13)
        }
    }
}

struct InnerCompassDataCenter: View {
    
    let sector: SectorData = SectorData(
        starLeft: 1,
        starRight: 1,
        starCenter: 1,
        leftColor: .black,
        rightColor: .black,
        centerColor: .black,
        isWater: true,
        isMountain: true,
        isFire: true
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                let textSize: CGFloat = 14
                let textWeight: Font.Weight = .regular
                
                iconView(
                    systemName: "flame.circle",
                    isVisible: sector.isFire,
                    color: .red
                )
                
                // ⛰ 💧 MIDDLE ICONS
                HStack(spacing: 12) {
                    iconView(
                        systemName: "triangle.fill",
                        isVisible: sector.isMountain,
                        color: .green
                    )
                    iconView(
                        systemName: "waveform.path.ecg",
                        isVisible: sector.isWater,
                        color: .blue
                    )
                }
                
                // ⭐ LEFT / RIGHT STARS
                HStack(alignment: .top, spacing: 0) {
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 5, height: 5)
                        .alignmentGuide(.firstTextBaseline) { d in
                            d[VerticalAlignment.firstTextBaseline]
                        }
                    
                    Text("\(sector.starLeft)")
                        .font(.system(size: textSize, weight: textWeight))
                        .foregroundColor(sector.leftColor)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 5, height: 5)
                    
                    
                    Text("\(sector.starRight)")
                        .font(.system(size: textSize, weight: textWeight))
                        .foregroundColor(sector.rightColor)
                        .padding(.leading, 10)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 5, height: 5)
                }
                
                Text("\(sector.starCenter)")
                    .font(.system(size: textSize, weight: textWeight))
                    .foregroundColor(sector.centerColor)
                
                if sector.isFire == true {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 5, height: 5)
                }
                
            }
            .frame(width: 70)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        }
    }
    
    // MARK: - Icon Helper
    @ViewBuilder
    private func iconView(
        systemName: String,
        isVisible: Bool?,
        color: Color
    ) -> some View {
        
        if isVisible == true {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 13, height: 13)
                .foregroundColor(color)
        } else {
            Color.clear
                .frame(width: 13, height: 13)
        }
    }
}



struct CompassDirectionLabels: View {
    let radius: CGFloat
    let directions = ["N", "E", "S", "W"]
    
    var body: some View {
        ForEach(0..<directions.count, id: \.self) { i in
            
            let angle = (Double(i) * 90)  + 22.5
            Text(directions[i])
                .background(Color.white.opacity(0.8))
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.red)
                .offset(y: -radius)
                .rotationEffect(.degrees(angle))
        }
    }
}


struct CompassDirectionDegreeLabels: View {
    let radius: CGFloat
    let heading: Double
    let directions = ["0°", "45°", "90°", "135°", "180°", "225°", "270°", "315°"]
    
    var body: some View {
        ForEach(0..<directions.count, id: \.self) { i in
            let angle = (Double(i) * 45)
            
            Text(directions[i])
                .background(Color.white.opacity(0.8))
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)
                .offset(y: -radius)
                .frame(maxWidth: 50)
                .rotationEffect(.degrees(angle))
            
        }
    }
}

// MARK: - Refactored Line Group
struct CompassLineGroup: View {
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
