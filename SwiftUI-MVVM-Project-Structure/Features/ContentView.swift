//
//  ContentView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()




import SwiftUI
import MapKit
import CoreLocation

// 1. Location Manager: Tracks real device movement
@available(iOS 17.0, *)
@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var heading: Double = 0.0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // trueHeading is North based on the map; magneticHeading is based on Earth's poles
        heading = newHeading.trueHeading >= 0 ? newHeading.trueHeading : newHeading.magneticHeading
    }
}

// 2. The Main Compass View
@available(iOS 17.0, *)
struct CompassLines: View {
    @State private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack {
            // MAP LAYER
            Map(position: $position) {
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
            }
            .ignoresSafeArea()

            // HUD LAYER (Top Left Info)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        if let loc = locationManager.userLocation {
                            Text("LAT: \(loc.latitude, specifier: "%.5f")")
                            Text("LNG: \(loc.longitude, specifier: "%.5f")")
                        } else {
                            Text("Locating...")
                        }
                        Text("HDG: \(Int(locationManager.heading))°")
                    }
                    .font(.system(.caption, design: .monospaced))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 50)
                Spacer()
            }

            // COMPASS OVERLAY LAYER
            ZStack {
                // This group rotates based on device heading
                Group {
                    ForEach(0..<24) { i in
                        let degree = Double(i) * 15
                        let isMainPoint = i % 3 == 0 // Every 45 degrees
                        
                        // DRAW LINES
                        Rectangle()
                            .fill(isMainPoint ? Color.red : Color.red.opacity(0.3))
                            .frame(width: isMainPoint ? 3 : 1, height: isMainPoint ? 320 : 280)
                            .offset(y: isMainPoint ? -160 : -140)
                            .rotationEffect(.degrees(degree))
                        
                        // DRAW LABELS (N, NE, E, SE, S, SW, W, NW)
                        if isMainPoint {
                            Text(directionLabel(for: i))
                                .font(.system(size: i % 6 == 0 ? 22 : 14, weight: .black, design: .monospaced))
                                .foregroundColor(i % 6 == 0 ? .orange : .red)
                                .offset(y: -195)
                                .rotationEffect(.degrees(degree))
                                .rotationEffect(.degrees(-degree)) // Keep text upright
                        }
                    }
                }
                .rotationEffect(.degrees(-locationManager.heading))

                // STATIC GUIDES (Do not rotate)
                Circle()
                    .stroke(Color.yellow.opacity(0.5), lineWidth: 2)
                    .frame(width: 300, height: 300)
                
                Circle()
                    .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "plus")
                    .foregroundColor(.yellow)
            }
            .allowsHitTesting(false)
        }
    }

    // FIXED: Mapping logic for all 8 directions
    private func directionLabel(for index: Int) -> String {
        switch index {
        case 0:  return "N"
        case 3:  return "NE"
        case 6:  return "E"
        case 9:  return "SE"
        case 12: return "S"
        case 15: return "SW"
        case 18: return "W"
        case 21: return "NW"
        default: return ""
        }
    }
}
