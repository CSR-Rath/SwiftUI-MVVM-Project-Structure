//
//  SwiftUI_MVVM_Project_StructureApp.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
import GoogleMaps
internal import Combine

//@available(iOS 17.0, *)
@main
struct SwiftUI_MVVM_Project_StructureApp: App {
    @StateObject var appState = AppStateManager()
    
    
    init() {
        
        GMSServices.provideAPIKey("AIzaSyDSXrwu6JBuY6VfJfjCcXDdOp2PqIwbGbk")//AIzaSyDSXrwu6JBuY6VfJfjCcXDdOp2PqIwbGbk
    }
    
    var body: some Scene {
        WindowGroup {
//            PostScreen()
            CommpassApp()
//            CompassOverlay()
//            CompassLines()
//            RootView()
//                .environmentObject(appState)
//                .onAppear(){
//                    
//                }
        }
    }
}
