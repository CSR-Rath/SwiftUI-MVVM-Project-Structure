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
    @State private var showHalfScreen = false
    
    let items: [FeatureItem]  = [
        FeatureItem(title: "Wallet", subtitle: "Manage Wallet", image: "wallet.pass", route: .wallet),
        FeatureItem(title: "Reward", subtitle: "Check Reward", image: "gift", route: .reward),
    ]
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            ForEach(items) { item in
                
                VStack(alignment: .leading) {
                    
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack{
                        Spacer()
                        Image(systemName: item.image)
                             .resizable()
                              .scaledToFit()
                              .frame(height: 80)
                              .foregroundColor(.orange)
                    }
                    .padding(0)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 0.5)
                .onTapGesture {

                    if item.route == AppRouteType.wallet{
                        showHalfScreen = true
                    }
                }
            }
        }
        .padding(0)
        
        .sheet(isPresented: $showHalfScreen) {
            
            HalfScreenView()
                .presentationDetents([.medium, .large])
        }
    }
}

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let route: AppRouteType
}

struct HalfScreenView: View {
    var body: some View {
        VStack {
            Text("This is a half-screen modal")
                .font(.title)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
