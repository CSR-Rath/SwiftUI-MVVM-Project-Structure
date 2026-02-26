//
//  KeychainManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 24/2/26.
//


internal import Foundation
import Security

final class KeychainManager {
    
    @discardableResult
    static func save(key: KeychainKeyEnum, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        // Delete if exists
        let queryDelete: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(queryDelete as CFDictionary)

        // Add new
        let queryAdd: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(queryAdd as CFDictionary, nil)
        
        debugLog("status ==> \(status == errSecSuccess)")
        return status == errSecSuccess
    }
    
    @discardableResult
    static func update(key: KeychainKeyEnum, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        return status == errSecSuccess
    }

    
    static func read(key: KeychainKeyEnum) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let result = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        debugLog("result ==> \(result)")
        return result
    }

    @discardableResult
    static func delete(key: KeychainKeyEnum) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        debugLog("status ==> \(status == errSecSuccess)")
        return status == errSecSuccess
    }
    
}
