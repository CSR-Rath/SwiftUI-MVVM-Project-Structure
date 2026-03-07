//
//  AppConfig.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

internal import Foundation

struct AppConfig {
    
    static var baseURL: String {
        Bundle.main.requiredString(for: .baseURL)
    }
    
    static var apiKey: String {
        Bundle.main.requiredString(for: .apiKey)
    }
    
    static var appVersion: String {
        Bundle.main.requiredString(for: .appVersion)
        
    }

    static var appBuildVersion: String {
        Bundle.main.requiredString(for: .buildVersion)
    }
    
    static var appBundleIdentifier: String {
        Bundle.main.requiredString(for: .appBundleIdetifier)
    }
    
    
}
