//
//  LocationManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 29/1/26.
//

import SwiftUI
internal import Combine
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var userLocation: CLLocation?
    @Published var degree: Double = 0.0   // 🧭 HEADING (0–360) DEGREE
    
    @Published var isLocationUpdating = false
    @Published var isHeadingUpdating = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.headingFilter = 1            // update every 1°
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    // 📍 User Location
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        userLocation = locations.last
        
        print("userLocation : \(userLocation?.coordinate.latitude ?? 0),  \(userLocation?.coordinate.longitude ?? 0), \(degree)")

    }

    // 🧭 degree
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading newHeading: CLHeading
    ) {
        degree = newHeading.trueHeading >= 0
            ? newHeading.trueHeading
            : newHeading.magneticHeading
        
        
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("❌ Location error:", error.localizedDescription)
    }
}


