//
//  LanguageManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 24/2/26.
//

import SwiftUI
internal import Combine

final class LanguageManager: ObservableObject {
    
    static let shared = LanguageManager()
    
    @Published var currentLanguage: LanguageKeyEnum {
        didSet {
            saveLanguage()
            updateBundle()
        }
    }
    
    private(set) var bundle: Bundle = .main
    
    private init() {
        // Load saved language or default to English
        if let savedLang = UserDefaultsManager.shared.getString(for: .appLanguage),
           let lang = LanguageKeyEnum(rawValue: savedLang) {
            self.currentLanguage = lang
        } else {
            self.currentLanguage = .english
        }
        updateBundle()
    }
    
    private func updateBundle() {
        guard let url = Bundle.main.url(forResource: currentLanguage.rawValue,
                                        withExtension: "lproj"),
              let bundle = Bundle(url: url) else {
            self.bundle = .main
            return
        }
        self.bundle = bundle
    }
    
    private func saveLanguage() {
        UserDefaultsManager.shared.set(currentLanguage.rawValue, for: .appLanguage)
    }
}
