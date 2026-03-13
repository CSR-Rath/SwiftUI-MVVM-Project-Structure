//
//  MainTabView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: TabEnum = .home
    @State private var previousTab: TabEnum = .home
    
    var isPush: Bool {
        selectedTab.rawValue > previousTab.rawValue
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color.bgcolor
            
            Group {
                switch selectedTab {
                case .home:
                    
                    TestView()
                case .search:
                    
                    NewsView()
                case .favorite:
                    
                    ProfileView()
                case .profile:
                    SettingsView()
                }
            }
            .id(selectedTab)
            .transition(
                .asymmetric(
                    insertion: .move(edge: isPush ? .trailing : .leading),
                    removal: .move(edge: isPush ? .leading : .trailing)
                )
            )
            .animation(.easeInOut(duration: 0.25), value: selectedTab)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBarView(
                selectedTab: $selectedTab,
                previousTab: $previousTab
            )
            .frame(height: 85)
            .frame(maxWidth: .infinity)
            .background(.gray)
        }
    }
}
