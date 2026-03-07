//
//  HomeUpgradeBannerView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeUpgradeBannerView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    var body: some View {
        HStack {
            
            Image(systemName: "rocket.fill")
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text("UPGRADE")
                    .bold()
                    .foregroundColor(.white)
                
                Text("Your account to enjoy full benefit.")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
        .background( Color.black)
        .cornerRadius(16)
        .onTapGesture {
          
            appState.push(.upgrade)
        }
        
    }
}
