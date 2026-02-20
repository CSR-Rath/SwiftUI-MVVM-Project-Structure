//
//  AppRouter.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI

enum AppRootType: String{
    case auth
    case home 
}

enum RouteType: Hashable {
    case settings
    case profile(userId: String)
    case details(productId: String)
}


extension RouteType {
    
    @ViewBuilder
    func build() -> some View {
        switch self {
            
        case .settings:
            SettingsView()
            
        case .profile(let userId):
            ProfileView(userId: userId)
            
        case .details(_):
            
            Text("testing")
        }
    }
}

