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
    
    @Published  var appRoute: [AppRouteType] = []

                    
        
    init() {
        loadRoot()
    }
    

    
    func switchRoot(_ root: AppRootType) {
        withAnimation(.easeInOut) {
            self.root = root

            appRoute.removeAll()
            saveRoot(root)
        }
    }
    
    
    // MARK: - Navigation Actions
    func push(_ route: AppRouteType , animation: Bool = true) {
        guard appRoute.last != route else { return }
        if animation {
            appRoute.append(route)
            
        }else{
            noAnimation {
                appRoute.append(route)
            }
        }
        
        debugLog(" Navigation Push -> \(route)")
    }
    
    func pop(animation: Bool = true) {
        guard !appRoute.isEmpty else { return }
        
        if animation{
            appRoute.removeLast()
            
        }else{
            noAnimation {
                appRoute.removeLast()
            }
        }
        
    }
    
    func popTo(_ route: AppRouteType) {
        if let index = appRoute.firstIndex(of: route) {
            // This is cleaner and prevents flickering
            appRoute = Array(appRoute.prefix(through: index))
        }
    }
    
    func popToRoot() {
        appRoute.removeAll()
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



