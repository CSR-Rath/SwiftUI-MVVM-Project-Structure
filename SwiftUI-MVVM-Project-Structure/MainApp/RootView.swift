//
//  RootView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    var body: some View {
        switch appState.root {
            
        case .tabBar:
            NavigationStack(path: $appState.appRoute) {
                MainTabView()
                    .navigationDestination(for: AppRouteType.self) { route in
                        route.build()
                    }
                    .ignoresSafeArea()
                    .navigationBarTitleDisplayMode(.inline)
            }
            
        case .auth:
            NavigationStack(path: $appState.appRoute) {
                AuthRootView()
                    .navigationDestination(for: AppRouteType.self) { route in
                        route.build()
                    }
                    .ignoresSafeArea()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
