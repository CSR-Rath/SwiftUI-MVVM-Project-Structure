//
//  HomeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
                .bold()

            Button("Go to Profile") {
                appState.push(.profile) // PUSH
            }

            Button("Go to Settings") {
                appState.push(.settings) // PUSH
            }

            Button("Logout") {
                appState.switchRoot(.auth) // POP + ROOT CHANGE
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}
