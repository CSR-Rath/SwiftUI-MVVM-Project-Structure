//
//  NewsView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
            
            Button("login_title".localized()) {
                appState.pop()
            }
        }
        .navigationTitle("News")
    }
}
