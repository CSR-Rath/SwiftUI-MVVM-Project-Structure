//
//  CurrencyCodeEnum.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

enum CurrencyCode: String {
    case usd = "USD"
    case khr = "KHR"
    
    var maxFractionDigits: Int {
        switch self {
        case .usd:
            return 2
        case .khr:
            return 0
        }
    }
}
