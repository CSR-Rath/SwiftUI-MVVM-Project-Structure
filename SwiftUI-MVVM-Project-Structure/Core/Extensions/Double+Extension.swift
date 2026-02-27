//
//  Double+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

import SwiftUI


extension Double {
    
    // MARK: - Private Helpers
    
    // Rounding = floor only one round down
    // Rounding = halfUp have up and down base number (5>=Up) (5>Down)
    
    // Computed Property use for no parameter needed ✔
    
    
    private var nonNegativeValue: Double {
        return self < 0 ? 0 : self
    }
    
    private func makeFormatter(
        minFraction: Int,
        maxFraction: Int,
        rounding: NumberFormatter.RoundingMode
    ) -> NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = rounding
        formatter.minimumFractionDigits = minFraction
        formatter.maximumFractionDigits = maxFraction
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        
        // Formate only US 🇺🇸
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }
    
//    private func formattedCurrency(_ currency: CurrencyCode) -> String {
//        
//        let formatter = makeFormatter(
//            minFraction: 0,//currency.maxFractionDigits == 0 ? 0 : 2,
//            maxFraction: currency.maxFractionDigits,
//            rounding: .halfUp
//        )
//        
//        let value = formatter.string(from: NSNumber(value: nonNegativeValue)) ?? "0"
//        
//        let language = LanguageManager.shared.currentLanguage
//        
//        switch language {
//        case .english:
//            return "\(currency.rawValue) \(value)"
//        default:
//            return "\(value) \(currency.rawValue)"
//        }
//    }
    
    private func formattedCurrency(_ currency: CurrencyCode) -> String {
        
        let value = nonNegativeValue
        
        let hasDecimal = value.truncatingRemainder(dividingBy: 1) != 0
        
        let formatter = makeFormatter(
            minFraction: hasDecimal ? currency.maxFractionDigits : 0,
            maxFraction: currency.maxFractionDigits,
            rounding: .halfUp
        )
        
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0"
        
        let language = LanguageManager.shared.currentLanguage
        
        switch language {
        case .english:
            return "\(currency.rawValue) \(formatted)"
        default:
            return "\(formatted) \(currency.rawValue)"
        }
    }
    
    // MARK: - Currency
    
    func toCurrency(_ currency: CurrencyCode) -> String {
        return formattedCurrency(currency)
    }
    
    var toCurrencyAsUSD: String {
        formattedCurrency(.usd)
    }
    
    var toCurrencyAsKHR: String {
        formattedCurrency(.khr)
    }
    
    
    // MARK: - Fuel
    
    var toAsLitter: String {
        let hasDecimal = nonNegativeValue.truncatingRemainder(dividingBy: 1) != 0
        
        let formatter = makeFormatter(
            minFraction: hasDecimal ? 2 : 0,
            maxFraction: hasDecimal ? 2 : 0,
            rounding: .floor
        )
        
        let value = formatter.string(from: NSNumber(value: nonNegativeValue)) ?? "0"
        
        let unit = nonNegativeValue > 1 ? "Liters".localized() : "Liter".localized()
        return value + " " + unit
    }
    
    var toNoLitter: String {
        let hasDecimal = nonNegativeValue.truncatingRemainder(dividingBy: 1) != 0
        
        let formatter = makeFormatter(
            minFraction: hasDecimal ? 2 : 0,
            maxFraction: hasDecimal ? 2 : 0,
            rounding: .floor
        )
        
        return formatter.string(from: NSNumber(value: nonNegativeValue)) ?? "0"
    }
    
    // MARK: - Points
    
    var toAsPoint: String {
        let hasDecimal = nonNegativeValue.truncatingRemainder(dividingBy: 1) != 0
        
        let formatter = makeFormatter(
            minFraction: hasDecimal ? 2 : 0,
            maxFraction: hasDecimal ? 2 : 0,
            rounding: .halfUp
        )
        
        let value = formatter.string(from: NSNumber(value: nonNegativeValue)) ?? "0"
        
        let label = nonNegativeValue > 1 ? "Points".localized() : "Point".localized()
        return value + " " + label
    }
    
    var toPoint: String {
        let hasDecimal = nonNegativeValue.truncatingRemainder(dividingBy: 1) != 0
        
        let formatter = makeFormatter(
            minFraction: hasDecimal ? 2 : 0,
            maxFraction: hasDecimal ? 2 : 0,
            rounding: .halfUp
            
        )
        
        return formatter.string(from: NSNumber(value: nonNegativeValue)) ?? "0"
    }
    
}
