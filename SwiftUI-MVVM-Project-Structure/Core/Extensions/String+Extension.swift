//
//  String+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

internal import Foundation



// MARK:
extension String {
    var isValidEmail: Bool {
        let emailRegex =
        "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        
        return NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: self)
    }
}


// MARK: This is Computed Property use for convert string to number
extension String {
    
    var toSafeDouble: Double {
        
        // Keep only numbers and decimal point
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        
        let cleaned = self
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: " ", with: "")
            .unicodeScalars
            .filter { allowedCharacters.contains($0) }
            .map { String($0) }
            .joined()
        
        return Double(cleaned) ?? 0.0
    }
    
    var toSafeInt: Int {
        return Int(self.toSafeDouble)
    }
}
