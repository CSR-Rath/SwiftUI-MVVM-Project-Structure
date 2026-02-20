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
    @Published  var homePath: [RouteType] = []
    
    init() {
        loadRoot()
    }
    
    // MARK: - Root Management
    func switchToHome() {
        withAnimation(.easeInOut) {
            self.root = .home
            self.homePath = []
            self.saveRoot(.home)
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
        guard homePath.last != route else { return }
        if animation {
            homePath.append(route)
            
        }else{
            noAnimation {
                homePath.append(route)
            }
        }
    }
    
    
    func pop(animation: Bool = true) {
        guard !homePath.isEmpty else { return }
        
        if animation{
            homePath.removeLast()
            
        }else{
            noAnimation {
                homePath.removeLast()
            }
        }
    }
    
    func popTo(_ route: RouteType) {
        if let index = homePath.firstIndex(of: route) {
            // This is cleaner and prevents flickering
            homePath = Array(homePath.prefix(through: index))
        }
    }
    
    func popToRoot() {
        homePath = []
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
        UserDefaults.standard.set(root.rawValue, forKey: UDKey.appRoot)
    }
    
    private func loadRoot() {
        if let raw = UserDefaults.standard.string(forKey: UDKey.appRoot),
           let root = AppRootType(rawValue: raw) {
            self.root = root
        } else {
            self.root = .auth
        }
    }
    
}
