//
//  AuthRootView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct AuthRootView: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var appState: NavigationRouter
    @State var showLoading = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                Button("Login") {
                    showLoading = true
                    vm.login(appState: appState) {
                        showLoading = false
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            if showLoading {
                LoadingView()
            }
        }
        .animation(.default, value: showLoading)
    }
}
