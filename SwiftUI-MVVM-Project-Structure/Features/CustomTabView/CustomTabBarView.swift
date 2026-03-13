//
//  CustomTabBarView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selectedTab: TabEnum
    @Binding var previousTab: TabEnum
    
    var body: some View {
        HStack {
            
            TabBarButton(
                icon: "house.fill",
                name: "Home",
                tab: .home,
                selectedTab: $selectedTab,
                previousTab: $previousTab
            )
            
            TabBarButton(
                icon: "magnifyingglass",
                name: "Search",
                tab: .search,
                selectedTab: $selectedTab,
                previousTab: $previousTab
            )
            
            TabBarButton(
                icon: "heart.fill",
                name: "Heart",
                tab: .favorite,
                selectedTab: $selectedTab,
                previousTab: $previousTab
            )
            
            TabBarButton(
                icon: "person.fill",
                name: "Setting",
                tab: .profile,
                selectedTab: $selectedTab,
                previousTab: $previousTab
            )
            
        }
    }
}
