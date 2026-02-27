//
//  CustomTabView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

import SwiftUI


enum Tab {
    case home
    case search
    case favorite
    case profile
}

struct CustomTabView: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color.bgcolor
            
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    NewsView()
                case .favorite:
                    SettingsView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity, maxHeight: 85)
                .background(.gray)
        }
    }
}

