//
//  TabbedItems.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case favorite
    case chat
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .chat:
            return "Chat"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "home-icon"
        case .favorite:
            return "favorite-icon"
        case .chat:
            return "chat-icon"
        case .profile:
            return "profile-icon"
        }
    }
}
