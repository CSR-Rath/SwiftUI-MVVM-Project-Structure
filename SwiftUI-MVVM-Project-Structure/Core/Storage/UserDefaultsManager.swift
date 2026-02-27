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
    
    // MARK: - Save Primitive
    
    func set<T>(_ value: T, for key: UserDefaultsKeyEnum) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    // MARK: - Save Codable
    
    func setCodable<T: Codable>(_ value: T, for key: UserDefaultsKeyEnum) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch {
            debugLog("❌ Encoding error: \(error)")
        }
    }
    
    // MARK: - Get Primitive
    
    func getString(for key: UserDefaultsKeyEnum) -> String? {
        defaults.string(forKey: key.rawValue)
    }
    
    func getBool(for key: UserDefaultsKeyEnum) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }
    
    func getInt(for key: UserDefaultsKeyEnum) -> Int {
        defaults.integer(forKey: key.rawValue)
    }
    
    // MARK: - Get Codable
    
    func getCodable<T: Codable>(_ type: T.Type,
                                for key: UserDefaultsKeyEnum) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugLog("❌ Decoding error: \(error)")
            return nil
        }
    }
    
    // MARK: - Remove
    
    func remove(for key: UserDefaultsKeyEnum) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
