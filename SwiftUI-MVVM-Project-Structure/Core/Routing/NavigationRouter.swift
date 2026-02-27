//
//  NavigationRouter.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 20/2/26.
//

import SwiftUI
internal import Combine

@MainActor
final class NavigationRouter: ObservableObject {
    @Published  var root: AppRootType = .auth
    @Published  var tabBarPath: [RouteType] = []
                    
        
    init() {
        loadRoot()
    }
    
    // MARK: - Root Management
    func switchToTabBar() {
        withAnimation(.easeInOut) {
            self.root = .tabbr
            self.tabBarPath = []
            self.saveRoot(.tabbr)
        }
    }
    
    func switchToAuth() {
        withAnimation(.easeInOut) {
            self.root = .auth
            self.saveRoot(.auth)
        }
    }
    
    // MARK: - Navigation Actions
    func push(_ route: RouteType , animation: Bool = true) {
        guard tabBarPath.last != route else { return }
        if animation {
            tabBarPath.append(route)
            
        }else{
            noAnimation {
                tabBarPath.append(route)
            }
        }
    }
    
    func pop(animation: Bool = true) {
        guard !tabBarPath.isEmpty else { return }
        
        if animation{
            tabBarPath.removeLast()
            
        }else{
            noAnimation {
                tabBarPath.removeLast()
            }
        }
    }
    
    func popTo(_ route: RouteType) {
        if let index = tabBarPath.firstIndex(of: route) {
            // This is cleaner and prevents flickering
            tabBarPath = Array(tabBarPath.prefix(through: index))
        }
    }
    
    func popToRoot() {
        tabBarPath = []
    }
    
    private func noAnimation(_ action: () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}

// MARK: - hadle save sesstion root
extension NavigationRouter{
    
    private func saveRoot(_ root: AppRootType) {
        UserDefaultsManager.shared.set(root.rawValue, for: .appRootState)
    }
    
    private func loadRoot() {
        if let raw = UserDefaultsManager.shared.getString(for: .appRootState),
           let root = AppRootType(rawValue: raw) {
            self.root = root
        } else {
            self.root = .auth
        }
    }
    
}
