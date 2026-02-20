//
//  SwiftUI_MVVM_Project_StructureApp.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI
internal import Combine

@main
struct SwiftUI_MVVM_Project_StructureApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // allow woring witth appDelegate
    @StateObject var appState = NavigationRouter()
    
    
    init() {
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .onAppear(){
                    appDelegate.appState = appState
                }
        }
    }
}

extension SwiftUI_MVVM_Project_StructureApp{
    

}

