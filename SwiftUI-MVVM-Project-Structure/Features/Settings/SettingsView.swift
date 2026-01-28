//
//  SettingsView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()

            Button("Back") {
                appState.pop()
            }
        }
        .padding()
    }
}

