//
//  Bundle+Info.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

internal import Foundation

extension Bundle {
    func requiredString(for key: InfoKey) -> String {
        guard let value = object(forInfoDictionaryKey: key.rawValue) as? String else {
            fatalError("❌ Missing Info.plist key: \(key.rawValue)")
        }
        return value
    }
}
