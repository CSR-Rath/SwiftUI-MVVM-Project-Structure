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
            
        case .tabbr:
            NavigationStack(path: $appState.tabBarPath) {
                CustomTabView()
                    .navigationDestination(for: RouteType.self) { route in
                        route.build()
                    }
                    .ignoresSafeArea()
                    .navigationBarTitleDisplayMode(.inline)
            }
            
        case .auth:
            NavigationStack(path: $appState.tabBarPath) {
                AuthRootView()
                    .navigationDestination(for: RouteType.self) { route in
                        route.build()
                    }
                    .ignoresSafeArea()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
