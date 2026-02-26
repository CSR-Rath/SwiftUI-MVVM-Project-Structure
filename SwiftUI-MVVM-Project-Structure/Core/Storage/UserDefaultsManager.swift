//
//  UserDefaultsManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 24/2/26.
//

internal import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Save
    
    func set<T>(_ value: T, for key: UserDefaultsKeyEnum) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    // MARK: - Get
    
    func getString(for key: UserDefaultsKeyEnum) -> String? {
        defaults.string(forKey: key.rawValue)
    }
    
    func getBool(for key: UserDefaultsKeyEnum) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }
    
    func remove(for key: UserDefaultsKeyEnum) {
        defaults.removeObject(forKey: key.rawValue)
    }
}

