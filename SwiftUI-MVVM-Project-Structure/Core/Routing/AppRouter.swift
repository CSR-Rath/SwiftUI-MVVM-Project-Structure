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
    case customerList
    case profile(userId: String)
    case details(productId: String)
}

// MARK: - ViewBuilder using for return one view,
extension RouteType {
    
    @ViewBuilder
    func build() -> some View {
        switch self {
            
        case .settings:
            SettingsView()
            
        case .profile(let userId):
            ProfileView(userId: userId)
            
        case .details(_):
            
            Text("Product Detail")
        case .customerList:
            
            CustomerListView()
        }
    }
}
