//
//  SwiftUI_MVVM_Project_StructureApp.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI
internal import Combine
import SwiftData

@main
struct SwiftUI_MVVM_Project_StructureApp: App {
    
    /// allow woring witth appDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = NavigationRouter()
    @AppStorage(AppStorageKey.appTheme) private var appTheme: AppTheme = .system
    
    
    init() {
        setUINavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            OTPView()
//            RootView()
                .environmentObject(appState)
                .environmentObject(LanguageManager.shared)
                .preferredColorScheme(colorScheme)
                .onReceive(NotificationCenter.default.publisher(for: .sessionExpired)) { _ in
                    
                    appState.switchRoot(.auth)
                }
                .onOpenURL { url in
                    // Deep link
                    
                    DeepLinkManager.shared.handle(url: url, router: appState)
                }
                .onAppear(){
                    
                    appDelegate.appState = appState
                }
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch appTheme {
        case .system:
            return nil // Follow system
        case .light:
            return .light // custom light
        case .dark:
            return .dark // custom dark
        }
    }
    
}

extension SwiftUI_MVVM_Project_StructureApp{
    
    private func setUINavigationBarAppearance(){
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithOpaqueBackground()
        scrollEdgeAppearance.backgroundColor = UIColor.clear
        scrollEdgeAppearance.shadowColor = .clear // line color
        
        
        scrollEdgeAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        scrollEdgeAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.white
        standardAppearance.shadowColor = .clear // line color
        
        standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        standardAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
    
}
