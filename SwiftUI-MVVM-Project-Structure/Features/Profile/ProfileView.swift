//
//  ProfileView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.largeTitle)
                .bold()

            Button("Pop (Back)") {
                appState.pop()
            }

            Button("Pop to Home") {
                appState.popToRoot()
            }
        }
        .padding()
    }
}
