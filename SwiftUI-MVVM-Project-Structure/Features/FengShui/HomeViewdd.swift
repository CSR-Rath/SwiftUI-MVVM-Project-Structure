//
//  HomeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 6/2/26.
//

import SwiftUI
import CoreLocation

struct CommpassApp: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var centerCoordinate: CLLocationCoordinate2D?
    @State private var mode: CompassDisplayMode = .compass
    
    

   
    //-----Labales Circle------
    private let labelsNESW24: CGFloat = 300
    private let labelsNESW4: CGFloat = 130
    
    //-----Lines X and Y-----
    private let lineXY: CGFloat = 280
    private let colorsXY: Color = Color.blue
   
    //----Circle View----
    private let circles: [CompassCircleStyle] = [
        CompassCircleStyle(size: 80, color: .purple, lineWidth: 2),
        CompassCircleStyle(size: 340, color: .purple, lineWidth: 2),
    ]
    
    private let mainLineColor: Color = Color.purple
    private let circleBig: CGFloat = 340
    private let circleSmall: CGFloat = 80
    
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                
                GoogleMapView(
                    location: $locationManager.userLocation,
                    centerCoordinate: $centerCoordinate
                )
                .ignoresSafeArea()
                
                ZStack {
                    ZStack {
                        /// long and short : - - - - - -
                        CompassTickMarksView()
                            .frame(width: circleBig, height: circleBig)
                        
                        /// labels circle
                        CompassDegreeLabelsView(heading: locationManager.degree)
                            .frame(width: labelsNESW24, height: labelsNESW24)
                        
                        /// labels circle
                        CompassCardinalDirectionsView(heading: locationManager.degree)
                            .frame(width: labelsNESW4, height: labelsNESW4)
                        
                        /// Items number in 3 per compass
                        InnerCompassDataCenterListView(heading: locationManager.degree, plus: 15)
                            .frame(width: 270, height:  270)
                        InnerCompassDataCenterListView(heading: locationManager.degree, plus: 30)
                            .frame(width: 270, height:  270)
                        InnerCompassDataCenterListView(heading: locationManager.degree, plus: 22.5)
                            .frame(width: 200, height:  200)
                    }
                    .opacity((mode == .compass || mode == .centerMarker) ? 1 : 0)
                    .animation(.easeInOut(duration: 0.25), value: mode)
                    
                    CompassLineGroupView(
                        degree: 45,
                        numberOfLines: 8,
                        lineSize: 800, // ✅ keep 800
                        lineColor: mainLineColor,
                        lineWidth: 2,
                        sizeClear: mode == .fullLinesCompass ? 0 : circleSmall
                    )
                    .opacity(mode == .none ? 0 : 1)
                    .animation(.easeInOut(duration: 0.25), value: mode)
                }
                .frame(width: circleBig, height: circleBig)
                .rotationEffect(.degrees(-locationManager.degree), anchor: .center)
                .animation(.linear(duration: 0.15), value: locationManager.degree)
                
                
                /// circle line 2
                ForEach(circles) { circle in
                    Circle()
                        .stroke(circle.color, lineWidth: circle.lineWidth)
                        .frame(width: circle.size, height: circle.size)
                }
                .opacity((mode == .compass || mode == .centerMarker) ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: mode)
                
                
                // lines center
                
               
                Group {
                    Rectangle()
                        .fill(colorsXY)
                        .frame(width: 1, height: lineXY)
                    
                    Rectangle()
                        .fill(colorsXY)
                        .frame(width: lineXY, height: 1)
                    
                    Circle()
                        .fill(colorsXY)
                        .frame(width: 10, height: 10)
                }
                .opacity((mode == .centerMarker) ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: mode)
                
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
                    
                }
            }
            
            
            VStack(spacing: 0) {
                
                HStack(spacing: 8) {
                    
                    let iconSize: CGFloat = 40
                    
                    Spacer()
                    
                    BaseButtonView(
                        title: "",
                        icon: "icon",
                        style: .icon,
                        size: iconSize
                    ) {
                        print("Icon tapped")
                    }
                    
                    BaseButtonView(
                        title: "",
                        icon: "icon",
                        style: .icon,
                        size: iconSize
                    ) {
                        print("Icon tapped")
                    }
                    
                    BaseButtonView(
                        title: "",
                        icon: "icon",
                        style: .icon,
                        size: iconSize
                    ) {
                        print("Icon tapped")
                    }
                    
                    BaseButtonView(
                        title: "",
                        icon: "icon",
                        style: .icon,
                        size: iconSize
                    ) {
                        print("Icon tapped")
                    }
                    
                    BaseButtonView(
                        title: "",
                        icon: "icon",
                        style: .icon,
                        size: iconSize
                    ) {
                        print("Icon tapped")
                    }
                    
                }
//                .background(Color.orange)
                
                HStack(spacing: 12) {
                    
                    BaseButton(title: "Compass") { mode = .compass }
                    BaseButton(title: "Maker") { mode = .centerMarker }
                    BaseButton(title: "Full Lines"){ mode = .fullLinesCompass }
                    
                }
                
                
                HStack(spacing: 12) {
                    BaseButton(title: "None") {
                        mode = .none
                    }
                    
                    BaseButton(title: "CenterLine") {
                        
                    }
                    
                    BaseButton(title: "Stars") {
                        
                    }
                }
                Spacer()
                
            }
            .padding(10)
            .frame(maxWidth: .infinity,maxHeight: 180)
            .background(Color.white)
        }
    }
}
