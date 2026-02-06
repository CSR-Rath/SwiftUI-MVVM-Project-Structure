//
//  AppState.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
internal import Combine


import SwiftUI

final class AppStateManager: ObservableObject {
    // 1. Single Source of Truth: Use a typed array instead of NavigationPath
    // This ensures 'routes' and the UI are ALWAYS in sync.
    @Published var path: [AppRoute] = []
    @Published var root: AppRoot = .auth
    
    init() {
        loadRoot()
    }
    
    // MARK: - Root Management
    func switchRoot(_ newRoot: AppRoot) {
        // Use transaction for more control over animation if needed
        withAnimation(.easeInOut(duration: 0.3)) {
            self.root = newRoot
            self.path = [] // Reset navigation on root change
            saveRoot(newRoot)
        }
    }
    
    // MARK: - Navigation
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popTo(_ route: AppRoute) {
        if let index = path.firstIndex(of: route) {
            // This is cleaner and prevents flickering
            path = Array(path.prefix(through: index))
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    // MARK: - Persistence (Decoupled logic)
    private func saveRoot(_ root: AppRoot) {
        UserDefaults.standard.set(root.rawValue, forKey: UDKey.appRoot)
    }
    
    private func loadRoot() {
        let savedValue = UserDefaults.standard.string(forKey: UDKey.appRoot)
        self.root = AppRoot(rawValue: savedValue ?? "") ?? .auth
    }
}

