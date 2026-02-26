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
    
    /// allow woring witth appDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    @StateObject private var appState = NavigationRouter()
    @StateObject private var languageManager = LanguageManager.shared
    
    
    
    
    var body: some Scene {
        WindowGroup {
           
            RootView()
                .environmentObject(appState)
                .environmentObject(languageManager)
                .onAppear(){
                    appDelegate.appState = appState
                    
                    print(languageManager.currentLanguage)
                    print(AppConfig.baseURL)
                    print(AppConfig.apiKey)
                    print(AppConfig.appVersion)
                    print(AppConfig.appBuildVersion)
                }

        }
    }
}
