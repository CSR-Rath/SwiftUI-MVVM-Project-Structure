//
//  CryptoConfig.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 9/2/26.
//

internal import Foundation


struct CryptoConfig {
    
    struct Payment {
        static let key = AppConfiguration.shared.paymentKey       // 32 chars
        static let iv  = AppConfiguration.shared.paymentVector    // 16 chars
    }

    struct Auth {
        static let key = AppConfiguration.shared.paymentKey
        static let iv  = AppConfiguration.shared.paymentVector
    }

    struct Transfer {
        static let key = AppConfiguration.shared.paymentKey
        static let iv  = AppConfiguration.shared.paymentVector
        static let hmac  = AppConfiguration.shared.paymentVector
    }
}


final class AppConfiguration {

    static let shared = AppConfiguration()

    private init() {}

    // MARK: - Info.plist Keys
    private enum InfoPlistKey: String {
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
        case bundleID = "BUNDLE_ID"
        case apiKey = "API_KEY"
        case baseURL = "BASE_URL"
        case paymentKey = "PAYMENT_KEY"
        case paymentVector = "PAYMENT_VECTOR"
    }

    // MARK: - App Info

    let versionApp: String = AppConfiguration.getValue(for: .version)
    let versionBuildApp: String = AppConfiguration.getValue(for: .build)
    let bundleID: String = AppConfiguration.getValue(for: .bundleID)

    // MARK: - API Configuration

    let apiKey: String = AppConfiguration.getValue(for: .apiKey)
    let apiBaseURL: String = AppConfiguration.getValue(for: .baseURL)

    // MARK: - Encryption Keys (AES-256, IV)

    let paymentKey: String = AppConfiguration.getValue(for: .paymentKey)
    let paymentVector: String = AppConfiguration.getValue(for: .paymentVector)

    // MARK: - Private Helper

    private static func getValue(for key: InfoPlistKey) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String,
              !value.isEmpty else {
            fatalError("❌ [AppConfiguration] Missing or empty '\(key.rawValue)' in Info.plist")
        }
        return value
    }
}
