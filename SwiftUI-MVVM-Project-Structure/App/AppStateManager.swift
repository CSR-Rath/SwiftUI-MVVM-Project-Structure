//
//  AppState.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
internal import Combine

//final class AppStateManager: ObservableObject {
//    
//    // Root control
//    @Published var root: AppRoot = .auth
//    
//    // Push navigation
//    @Published private(set) var routes: [AppRoute] = []
//    @Published var path = NavigationPath()
//    
//    init() {
//        loadRoot()
//    }
//    
//    func switchRoot(_ newRoot: AppRoot) {
//        withAnimation(.easeInOut(duration: 0.3)) {
//            root = newRoot
//            path = NavigationPath()
//            saveRoot(newRoot)
//        }
//    }
//    
//    // MARK: Push
//    func push(_ route: AppRoute) {
//        routes.append(route)
//        path.append(route)
//    }
//    
//    // MARK: Pop
//    func pop() {
//        guard !routes.isEmpty else { return }
//        routes.removeLast()
//        path.removeLast()
//    }
//    
//    //MARK: POP TO SPECIFIC VIEW
//    func popTo(_ route: AppRoute) {
//        guard let index = routes.firstIndex(of: route) else { return }
//        
//        let removeCount = routes.count - index - 1
//        routes.removeLast(removeCount)
//        
//        path = NavigationPath()
//        routes.forEach { path.append($0) }
//    }
//    
//    // MARK: Pop to Root (Home)
//    func popToRoot() {
//        routes.removeAll()
//        path = NavigationPath()
//    }
//    
//    // MARK: - USER DEFAULTS
//    private func saveRoot(_ root: AppRoot) {
//        UserDefaults.standard.set(root, forKey: UDKey.appRoot)
//    }
//    
//    
//    private func loadRoot() {
//        guard let value = UserDefaults.standard.string(forKey: UDKey.appRoot),
//        let savedRoot = AppRoot(rawValue: value) else {
//            root = .auth
//            return
//        }
//        root = savedRoot
//    }
//}


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

