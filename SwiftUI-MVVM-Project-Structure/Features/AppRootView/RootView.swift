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
            
        case .home:
            NavigationStack(path: $appState.homePath) {
                HomeView()
                    .navigationDestination(for: RouteType.self) { route in
                        route.build()
                    }
            }
            
        case .auth:
            NavigationStack(path: $appState.homePath) {
                AuthRootView()
                    .navigationDestination(for: RouteType.self) { route in
                        route.build()
                    }
            }
        }
    }
}
