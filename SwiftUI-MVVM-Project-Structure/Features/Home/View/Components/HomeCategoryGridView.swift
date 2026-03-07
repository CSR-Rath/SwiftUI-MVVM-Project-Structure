//
//  HomeCategoryGridView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeCategoryGridView: View {
    
    @EnvironmentObject var appState: NavigationRouter
    
    let items: [CategoryItem] = [
        CategoryItem(title: "Fun", route: .fun),
        CategoryItem(title: "Special Offer", route: .specialOffer),
        CategoryItem(title: "Travel", route: .travel),
        CategoryItem(title: "Charity", route: .charity)
    ]
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            ForEach(items) { item in
                
                VStack(spacing: 8) {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange.opacity(0.2))
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text(item.title)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {

                    appState.push(item.route)
                }
            }
        }
    }
}

struct CategoryItem: Identifiable {
    let id = UUID()
    let title: String
    let route: RouteType
}
