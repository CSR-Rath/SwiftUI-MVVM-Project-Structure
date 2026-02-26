//
//  Optional+Extensions.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 24/2/26.
//

internal import Foundation

// For text
extension Optional where Wrapped == String {

    var isBlank: Bool {
        guard let value = self else { return true }
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNotBlank: Bool {
        return !isBlank
    }
}

// For number
extension Optional where Wrapped: Numeric {
    
    var valueOrZero: Wrapped {
       return self ?? .zero
    }
    
    var isNilOrZero: Bool {
        return valueOrZero == .zero
    }
}
