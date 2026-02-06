import SwiftUI
import GoogleMaps
import CoreLocation

struct GoogleMapView: UIViewRepresentable {
    
    @Binding var location: CLLocation?
    @Binding var centerCoordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(
            withLatitude: location?.coordinate.latitude ?? 12.5657,
            longitude: location?.coordinate.longitude ?? 104.9910,
            zoom: 17
        )
        
        let mapView = GMSMapView()
        mapView.camera  = camera

        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = false
        mapView.settings.myLocationButton = false
        mapView.delegate = context.coordinator
        
        //Show maker default
        context.coordinator.marker.map = mapView
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let loc = location, centerCoordinate == nil {
            uiView.moveCamera(GMSCameraUpdate.setTarget(loc.coordinate))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, GMSMapViewDelegate {
        
        var parent: GoogleMapView
        let marker = GMSMarker()
        private let geocoder = GMSGeocoder()
        
        init(_ parent: GoogleMapView) {
            self.parent = parent
            super.init()
            
            //Set position maker X and Y (min 0 mx 1)
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.groundAnchor = CGPoint(x: 0.5, y: 1.0)
        }
        
        //MARK: this func get currect location center screen this point maker
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            
            let center = position.target
            
            parent.centerCoordinate = center
            marker.position = center
            
            // degube log address
            geocoder.reverseGeocodeCoordinate(center) { response, error in
                guard
                    let result = response?.firstResult(),
                    let lines = result.lines
                else { return }
                
                
                print("Address: ", lines.joined(separator: ", "))
            }
        }
    }
}
