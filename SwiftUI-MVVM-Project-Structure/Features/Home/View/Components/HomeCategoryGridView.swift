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
        CategoryItem(title: "Fun", image: "face.smiling", route: .fun),
        CategoryItem(title: "Special Offer", image: "tag.fill", route: .specialOffer),
        CategoryItem(title: "Travel", image: "airplane", route: .travel),
        CategoryItem(title: "Charity", image: "heart.fill", route: .charity)
    ]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(items) { item in
                VStack(spacing: 5) {
                    Spacer()
                    Image(systemName: item.image)
                        .resizable()
                        .scaledToFit()
                        // Using a slightly smaller frame for the icon to match the screenshot
                        .frame(width: 30, height: 30)
                        .foregroundColor(.orange)
                    
                    Text(item.title)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(1) // Keep it clean like the screenshot
                        .minimumScaleFactor(0.8)
                    Spacer()
                }

                // --- DYNAMIC SQUARE LOGIC ---
                .frame(maxWidth: .infinity)      // Fills 1/4 of available row width
                .aspectRatio(1, contentMode: .fit) // Forces Height to equal Width
                // -----------------------------
                .background(Color.white)
                .cornerRadius(12) // Slightly rounded corners as seen in UI
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2) // Subtle shadow
                .onTapGesture {
                    appState.push(item.route)
                }
            }
        }
        // No fixed height here; let the aspectRatio handle it!
        .frame(maxWidth: .infinity)
    }
}

struct CategoryItem: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let route: AppRouteType
}
