//
//  IPhoneStyleCalculator.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

internal import Foundation


struct IPhoneStyleCalculator {
    
    // MARK: - Public

    static func calculate(_ lhs: String,
                          _ rhs: String,
                          operation: Operation) -> String {
        
        let left = decimal(lhs)
        let right = decimal(rhs)
        
        var result: Decimal = 0
        
        switch operation {
        case .add:
            result = left + right
            
        case .subtract:
            result = left - right
            
        case .multiply:
            result = left * right
            
        case .divide:
            guard right != 0 else { return "Error" }
            result = left / right
        }
        
        return format(result)
    }
}

// MARK: - Operation
extension IPhoneStyleCalculator {
    
    enum Operation {
        case add, subtract, multiply, divide
    }
}

// MARK: - Helpers
extension IPhoneStyleCalculator {
    
    private static func decimal(_ value: String) -> Decimal {
        return Decimal(string: value) ?? 0
    }
    
    private static func format(_ value: Decimal) -> String {
        var rounded = value
        
        // Round like iPhone (max 10 fraction digits)
        var result = Decimal()
        NSDecimalRound(&result, &rounded, 10, .plain)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10
        formatter.minimumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        
        return formatter.string(for: result) ?? "0"
    }
}


let result = IPhoneStyleCalculator.calculate(
    "5.55",
    "1.11",
    operation: .divide
)

// result = 5 but use simple in programming 4.99....
