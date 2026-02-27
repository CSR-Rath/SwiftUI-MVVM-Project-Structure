//
//  LoginViewModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

internal import Combine

final class LoginViewModel: ObservableObject {
    
    func login(appState: NavigationRouter,
               completion: @escaping () -> Void) {
        
        Task {
            await MainActor.run {
                completion()
                appState.switchToTabBar()
            }
        }
    }
}

