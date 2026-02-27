//
//  DeepLinkKey.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

// Use DeepLinkKey to control routing from another app
enum DeepLinkKey {
    case detail(productId: String)
    case profile(userId: String)
    case settings
}
