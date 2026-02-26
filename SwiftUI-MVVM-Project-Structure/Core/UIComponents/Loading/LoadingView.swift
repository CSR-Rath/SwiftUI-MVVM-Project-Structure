//
//  LoadingView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 20/2/26.
//

import SwiftUI
internal import Combine

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                
                Text("Loading...")
            }
            .frame(width: 120, height: 120)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            )
            .offset(y: -30)
        }
    }
}
