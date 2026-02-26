//
//  localized.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

internal import Foundation

extension String {
    
    func localized() -> String {
        
        let lang = LanguageManager.shared.currentLanguage.rawValue
        
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
