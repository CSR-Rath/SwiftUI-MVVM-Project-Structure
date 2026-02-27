//
//  CustomTabBar.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            
            TabBarButton(
                icon: "house.fill",
                name: "Home",
                tab: .home,
                selectedTab: $selectedTab
            )
            
            TabBarButton(
                icon: "magnifyingglass",
                name: "Shearch",
                tab: .search,
                selectedTab: $selectedTab
            )
            
            TabBarButton(
                icon: "heart.fill",
                name: "Heart",
                tab: .favorite,
                selectedTab: $selectedTab
            )
            
            TabBarButton(
                icon: "person.fill",
                name: "Person",
                tab: .profile,
                selectedTab: $selectedTab
            )
        }
    }
}
