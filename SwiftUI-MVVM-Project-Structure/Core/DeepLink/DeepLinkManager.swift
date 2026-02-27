//
//  DeepLinkManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

// DeepLinkManager handles specific navigation routes
final class DeepLinkManager {
    
    static let shared = DeepLinkManager()
    
    private init() {}
    
    func openAppOrAppStore(appScheme: String, appStoreID: String) {
        guard let appURL = URL(string: "\(appScheme)://") else { return }
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            guard let storeURL = URL(string: "https://apps.apple.com/app/id\(appStoreID)") else { return }
            UIApplication.shared.open(storeURL)
        }
    }
    
    func handle(url: URL, router: NavigationRouter) {
        
        debugLog("Deep link: \(url.absoluteString)")
        
        guard let deepLink = parse(url: url) else {
            debugLog("Invalid deep link")
            return
        }
        
        // Switch root flow (if needed)
        router.root = .tabbr
        
        // Reset navigation stack
        router.popToRoot()
        
        switch deepLink{
        case .detail(productId: let productId):
            router.push(.details(productId: productId))
        case .profile(userId: let userId):
            router.push(.profile(userId: userId))
        case .settings:
            router.push(.settings)
        }
    }
    
}

// MARK: - Parsing
private extension DeepLinkManager {
    
    func parse(url: URL) -> DeepLinkKey? {
        
        guard let host = url.host,
              let deepLinkHost = DeepLinkHost(rawValue: host) else {
            print("Invalid host:", url)
            return nil
        }
        
        /*
         
         Example: myapp://details/123
         host = details
         pathComponents = 123
         
         */

        
        // Safer than filtering "/"
        let components = url.pathComponents.dropFirst()
        
        switch deepLinkHost {
            
        case .detail:
            guard let id = components.first else { return nil }
            return .detail(productId: id)
            
        case .profile:
            guard let id = components.first else { return nil }
            return .profile(userId: id)
            
        case .settings:
            return .settings
        }
    }
}
