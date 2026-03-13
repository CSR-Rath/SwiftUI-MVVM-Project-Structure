//
//  HomeHeaderView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var body: some View {
        VStack{
            Spacer()
            HStack(spacing: 10) {
                
                Image("imageBanner")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                
                VStack(alignment: .leading) {
                    Text("login_title".localized())
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Text("Sok Panha")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                CircleButton(icon: "iconClose",iconSize: 30, size: 24) {
                    
                }
                
                CircleButton(icon: "iconClose",iconSize: 30, size: 24) {
                    
                }
            }
        }
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.cyan)
    }
}
