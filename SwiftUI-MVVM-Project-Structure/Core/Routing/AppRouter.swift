//
//  AppRouter.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI

enum AppRootType: String{
    case auth
    case tabbr 
}


// MARK: - We use Hashable because NavigationStack requires it.
enum RouteType: Hashable {
    case settings
    case customerList
    case dragdrop
    case profile(userId: String)
    case details(productId: String)
    
}

extension RouteType {
    
    @ViewBuilder
    func build() -> some View {
        switch self {
            
        case .settings:
            SettingsView()
            
        case .profile(let  userId):
            ProfileView()
            
        case .details(_):
            
            Text("Product Detail")
        case .customerList:
            
            CustomerListView()
        case .dragdrop:
            DragDropListView()
        }
    }
}
