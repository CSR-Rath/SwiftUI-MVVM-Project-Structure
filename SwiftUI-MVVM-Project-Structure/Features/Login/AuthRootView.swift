//
//  AuthRootView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI
internal import Combine

struct AuthRootView: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()

            Button("Login") {
                vm.login(appState: appState)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

final class LoginViewModel: ObservableObject {
    func login(appState: AppStateManager) {
        appState.switchRoot(.home) // CHANGE ROOT (NO BACK)
    }
}
