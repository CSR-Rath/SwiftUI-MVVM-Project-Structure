//
//  AppRouter.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI

// MARK: - We use Hashable because NavigationStack requires it.
enum AppRouteType: Hashable {
  
    case customerList
    case dragdrop
    case profile(userId: String)
    case details(productId: String)
    case scanner
    case baseTextField
    
    
    // MARK: -  HomeView
    case fun
    case specialOffer
    case travel
    case charity
    case wallet
    case reward
    case upgrade
    case memberShip
    
    
    // MARK: -  Setting
    case settings
    
    

    
    
}

extension AppRouteType {
    
    @ViewBuilder
    func build() -> some View {
        switch self {
            
        case .settings:
            SettingsView()
            
        case .profile(_):
            ProfileView()
            
        case .details(_):
            Text("Product Detail")
            
        case .customerList:
            CustomerListView()
            
        case .dragdrop:
            DragDropListView()
            
        case .scanner:
            ScanQRCodeView()
            
        case .baseTextField:
            TestTextFieldView()
            
        case .fun:
            Text("Fun View")
            
        case .specialOffer:
            Text("Special Offer")
            
        case .travel:
            Text("Travel View")
            
        case .charity:
            Text("Charity View")
            
        case .wallet:
            Text("Wallet View")
            
        case .reward:
            Text("Reward View")
            
        case .upgrade:
            Text("Upgrade View")
            
        case .memberShip:
            Text("Membership View")
        }
    }
}
