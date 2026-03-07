//
//  HomeFeatureCardView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//


import SwiftUI
internal import Combine

struct HomeFeatureCardView: View {
    
    @EnvironmentObject var appState: NavigationRouter
    
    let items: [FeatureItem]  = [
        FeatureItem(title: "Wallet", subtitle: "Manage Wallet", image: "wallet.pass", route: .wallet),
        FeatureItem(title: "Reward", subtitle: "Check Reward", image: "gift", route: .reward),
        
    ]
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            ForEach(items) { item in
                
                VStack(alignment: .leading) {
                    
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: item.image)
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 2)
                .onTapGesture {
                    print("Testing: \(item)")
                    appState.push(item.route)
                }
                
            }
        }
        .padding(0)
    }
}


struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let route: RouteType
}
