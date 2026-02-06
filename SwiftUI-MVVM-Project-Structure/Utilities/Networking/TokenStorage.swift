//
//  TokenStorage.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 5/2/26.
//

internal import Foundation

enum TokenStorage {
    static func saveAccessToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "access_token")
    }
    
    static func saveRefreshToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "refresh_token")
    }
    
    static func accessToken() -> String? {
        UserDefaults.standard.string(forKey: "access_token")
    }
    
    static func refreshToken() -> String? {
        UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
    }
}
