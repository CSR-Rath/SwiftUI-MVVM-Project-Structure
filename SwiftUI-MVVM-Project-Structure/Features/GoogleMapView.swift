////import SwiftUI
////import GoogleMaps
////import CoreLocation
////
////// 1. Updated GoogleMapView with "Initial Center" logic
////struct GoogleMapView: UIViewRepresentable {
////    @Binding var center: CLLocationCoordinate2D
////    @Binding var heading: Double
////    var userLocation: CLLocationCoordinate2D? // Pass user location here
////    
////    func makeUIView(context: Context) -> GMSMapView {
////        // Start at current center
////        let camera = GMSCameraPosition.camera(withTarget: center, zoom: 15)
////        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
////        
////        mapView.delegate = context.coordinator
////        mapView.isMyLocationEnabled = true
////        mapView.settings.myLocationButton = true // Adds the "target" button
////        
////        return mapView
////    }
////    
////    func updateUIView(_ uiView: GMSMapView, context: Context) {
////        // If we just got a user location and the map is still at the default, move it
////        if let userLoc = userLocation, center.latitude == 37.7749 {
////            let update = GMSCameraUpdate.setTarget(userLoc)
////            uiView.animate(with: update)
////        }
////    }
////    
////    func makeCoordinator() -> Coordinator {
////        Coordinator(self)
////    }
////    
////    class Coordinator: NSObject, GMSMapViewDelegate {
////        var parent: GoogleMapView
////        init(_ parent: GoogleMapView) { self.parent = parent }
////        
////        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
////            // Update the bindings so the UI knows where the map is looking
////            DispatchQueue.main.async {
////                self.parent.center = position.target
////                self.parent.heading = position.bearing
////            }
////        }
////    }
////}
////
////@available(iOS 17.0, *)
////struct GoogleCompassView: View {
////    @State private var locationManager = LocationManager()
////    
////    // Default to SF, but updateUIView will move this to current location
////    @State private var mapCenter = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
////    @State private var mapHeading: Double = 0.0
////    
////    var body: some View {
////        ZStack {
////            // 1. Google Maps Layer (Passes userLocation to helper)
////            GoogleMapView(
////                center: $mapCenter,
////                heading: $mapHeading,
////                userLocation: locationManager.userLocation
////            )
////            .ignoresSafeArea()
////            
////            // 2. Data HUD (Shows LIVE data from LocationManager)
////            VStack {
////                HStack {
////                    VStack(alignment: .leading, spacing: 4) {
////                        if let loc = locationManager.userLocation {
////                            Text("LAT: \(loc.latitude, specifier: "%.5f")")
////                            Text("LNG: \(loc.longitude, specifier: "%.5f")")
////                        } else {
////                            Text("Waiting for GPS...")
////                        }
////                        // Use locationManager.heading for physical device rotation
////                        Text("HDG: \(Int(locationManager.heading))°")
////                    }
////                    .font(.system(.footnote, design: .monospaced))
////                    .padding(8)
////                    .background(.ultraThinMaterial)
////                    .cornerRadius(8)
////                    Spacer()
////                }
////                .padding(.leading, 10)
////                .padding(.top, 50)
////                Spacer()
////            }
////
////            // 3. SwiftUI Compass Overlay
////            ZStack {
////                Group {
////                    ForEach(0..<24) { i in
////                        let isMainPoint = i % 3 == 0
////                        let degree = Double(i) * 15
////                        
////                        Rectangle()
////                            .fill(isMainPoint ? Color.red : Color.red.opacity(0.3))
////                            .frame(width: isMainPoint ? 3 : 1, height: isMainPoint ? 320 : 280)
////                            .offset(y: isMainPoint ? -160 : -140)
////                            .rotationEffect(.degrees(degree))
////                        
////                        if isMainPoint {
////                            Text(directionLabel(for: i))
////                                .font(.system(size: i % 6 == 0 ? 20 : 12, weight: .black))
////                                .foregroundColor(i % 6 == 0 ? .orange : .red)
////                                .offset(y: -195)
////                                .rotationEffect(.degrees(degree))
////                                .rotationEffect(.degrees(-degree))
////                        }
////                    }
////                }
////                // Rotates the custom compass to match device orientation
////                .rotationEffect(.degrees(-locationManager.heading))
////
////                // Static Guides
////                Circle()
////                    .stroke(Color.yellow.opacity(0.5), lineWidth: 2)
////                    .frame(width: 300, height: 300)
////                
////                Image(systemName: "plus")
////                    .foregroundColor(.yellow)
////            }
////            .allowsHitTesting(false)
////        }
////    }
////
////    private func directionLabel(for index: Int) -> String {
////        let labels = [0: "N", 3: "NE", 6: "E", 9: "SE", 12: "S", 15: "SW", 18: "W", 21: "NW"]
////        return labels[index] ?? ""
////    }
////}
//
//
//import CoreLocation
//internal import Combine
//
//final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//    private let manager = CLLocationManager()
//
//    @Published var userLocation: CLLocationCoordinate2D?
//    @Published var heading: Double = 0
//
//    override init() {
//        super.init()
//
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.headingFilter = 1
//
//        requestPermission()
//        manager.startUpdatingHeading()
//    }
//
//    private func requestPermission() {
//        if manager.authorizationStatus == .notDetermined {
//            manager.requestWhenInUseAuthorization()
//        }
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//
//        case .authorizedWhenInUse, .authorizedAlways:
//            manager.startUpdatingLocation()
//
//        case .denied, .restricted:
//            print("❌ Location permission denied")
//
//        case .notDetermined:
//            break
//
//        @unknown default:
//            break
//        }
//    }
//
//    func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateLocations locations: [CLLocation]
//    ) {
//        guard let location = locations.last else { return }
//        DispatchQueue.main.async {
//            self.userLocation = location.coordinate
//        }
//    }
//
//    func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateHeading newHeading: CLHeading
//    ) {
//        DispatchQueue.main.async {
//            self.heading = newHeading.trueHeading > 0
//                ? newHeading.trueHeading
//                : newHeading.magneticHeading
//        }
//    }
//}
//
//
//import SwiftUI
//import GoogleMaps
//import CoreLocation
//
//struct GoogleMapView: UIViewRepresentable {
//
//    @Binding var center: CLLocationCoordinate2D
//    @Binding var mapBearing: Double
//    @Binding var hasCenteredOnUser: Bool
//
//    var userLocation: CLLocationCoordinate2D?
//
//    func makeUIView(context: Context) -> GMSMapView {
//
//        let camera = GMSCameraPosition.camera(
//            withLatitude: center.latitude,
//            longitude: center.longitude,
//            zoom: 15
//        )
//
//        let mapView = GMSMapView(frame: .zero, camera: camera)
//        mapView.delegate = context.coordinator
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//
//        return mapView
//    }
//
//    func updateUIView(_ mapView: GMSMapView, context: Context) {
//
//        guard
//            let userLoc = userLocation,
//            hasCenteredOnUser == false
//        else { return }
//
//        let camera = GMSCameraPosition(
//            target: userLoc,
//            zoom: 16,
//            bearing: 0,
//            viewingAngle: 0
//        )
//
//        mapView.animate(to: camera)
//
//        DispatchQueue.main.async {
//            center = userLoc
//            hasCenteredOnUser = true
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, GMSMapViewDelegate {
//
//        let parent: GoogleMapView
//
//        init(_ parent: GoogleMapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//            DispatchQueue.main.async {
//                self.parent.center = position.target
//                self.parent.mapBearing = position.bearing
//            }
//        }
//    }
//}
//
//
//@available(iOS 17.0, *)
//struct GoogleCompassView: View {
//
//    @StateObject private var locationManager = LocationManager()
//
//    @State private var mapCenter =
//        CLLocationCoordinate2D(latitude: 0, longitude: 0)
//
//    @State private var mapBearing: Double = 0
//    @State private var hasCenteredOnUser = false
//
//    var body: some View {
//        ZStack {
//
//            GoogleMapView(
//                center: $mapCenter,
//                mapBearing: $mapBearing,
//                hasCenteredOnUser: $hasCenteredOnUser,
//                userLocation: locationManager.userLocation
//            )
//            .ignoresSafeArea()
//
//            // 📍 HUD
//            VStack {
//                HStack {
//                    VStack(alignment: .leading, spacing: 4) {
//                        if let loc = locationManager.userLocation {
//                            Text("LAT: \(loc.latitude, specifier: "%.5f")")
//                            Text("LNG: \(loc.longitude, specifier: "%.5f")")
//                        } else {
//                            Text("Waiting for GPS…")
//                        }
//
//                        Text("HDG: \(Int(locationManager.heading))°")
//                    }
//                    .font(.system(.footnote, design: .monospaced))
//                    .padding(8)
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(8)
//
//                    Spacer()
//                }
//                .padding(.leading, 10)
//                .padding(.top, 50)
//
//                Spacer()
//            }
//
//            // 🧭 Compass Overlay
//            ZStack {
//                Group {
//                    ForEach(0..<24) { i in
//                        let isMain = i % 3 == 0
//                        let degree = Double(i) * 15
//
//                        Rectangle()
//                            .fill(isMain ? .red : .red.opacity(0.3))
//                            .frame(
//                                width: isMain ? 3 : 1,
//                                height: isMain ? 320 : 280
//                            )
//                            .offset(y: isMain ? -160 : -140)
//                            .rotationEffect(.degrees(degree))
//
//                        if isMain {
//                            Text(directionLabel(for: i))
//                                .font(.system(
//                                    size: i % 6 == 0 ? 20 : 12,
//                                    weight: .black
//                                ))
//                                .foregroundColor(i % 6 == 0 ? .orange : .red)
//                                .offset(y: -195)
//                                .rotationEffect(.degrees(degree))
//                                .rotationEffect(.degrees(-degree))
//                        }
//                    }
//                }
//                .rotationEffect(.degrees(-locationManager.heading))
//
//                Circle()
//                    .stroke(.yellow.opacity(0.5), lineWidth: 2)
//                    .frame(width: 300, height: 300)
//
//                Image(systemName: "plus")
//                    .foregroundColor(.yellow)
//            }
//            .allowsHitTesting(false)
//        }
//    }
//
//    private func directionLabel(for index: Int) -> String {
//        let labels = [
//            0: "N", 3: "NE", 6: "E", 9: "SE",
//            12: "S", 15: "SW", 18: "W", 21: "NW"
//        ]
//        return labels[index] ?? ""
//    }
//}
