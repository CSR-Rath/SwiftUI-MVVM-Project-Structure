//
//  SessionManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

internal import Foundation

final class SessionManager {
    static let shared = SessionManager()
    
    func expireSession() {
        NotificationCenter.default.post(name: .sessionExpired, object: nil)
    }
}
