//
//  HomeRootView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//


import SwiftUI

struct HomeRootView: View {
    @EnvironmentObject var appState: AppStateManager
    
    var body: some View {
        NavigationStack(path: $appState.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .profile:
                        ProfileView()
                    case .settings:
                        SettingsView()
                    }
                }
        }
    }
}
