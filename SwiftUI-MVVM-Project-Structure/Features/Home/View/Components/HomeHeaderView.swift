//
//  HomeHeaderView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var body: some View {
        HStack {
            
            Image("profile")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            
            
            VStack(alignment: .leading) {
                Text("Welcome")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Sok Panha")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            
            
            Button {
                // action when tapped
                print("QR Code tapped")
            } label: {
                Image(systemName: "qrcode")
            }
            .frame(width: 24,height: 24)
            
            Button {
                // action when tapped
                print("Bell tapped")
            } label: {
                Image(systemName: "bell")
            }
            .frame(width: 24,height: 24)
        }
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}
