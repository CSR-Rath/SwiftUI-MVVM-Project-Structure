//
//  TabBarButton.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI


struct TabBarButton: View {
    
    let icon: String
    let name: String
    let tab: TabEnum
    
    @Binding var selectedTab: TabEnum
    @Binding var previousTab: TabEnum
    
    var body: some View {
        
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                previousTab = selectedTab
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 5) {
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(
                        selectedTab == tab ? .black : .white
                    )
                
                Text(name)
                    .font(.system(size: 16))
                    .foregroundColor(
                        selectedTab == tab ? .black : .white
                    )
            }
            .frame(maxWidth: .infinity)
        }
    }
}
