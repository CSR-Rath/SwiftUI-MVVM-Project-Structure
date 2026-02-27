//
//  Fonts+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

enum AppFontWeight {
    case regular
    case medium
    case bold
}

extension Font {
    
    static func appFont(_ weight: AppFontWeight = .regular, size: CGFloat) -> Font {
        
        let language = LanguageManager.shared.currentLanguage
        
        let fontName: String
        
        switch (language, weight) {
            
            // MARK: - Khmer Fonts
        case (.khmer, .regular):
            fontName = "NotoSansKhmer-Regular"
        case (.khmer, .medium):
            fontName = "NotoSansKhmer-Medium"
        case (.khmer, .bold):
            fontName = "NotoSansKhmer-Bold"
            
            // MARK: - English Fonts
        case (.english, .regular):
            fontName = "Roboto-Regular"
        case (.english, .medium):
            fontName = "Roboto-Medium"
        case (.english, .bold):
            fontName = "Roboto-Bold"
            
            // MARK: - Chinese Fonts
        case (.chinese, .regular):
            fontName = "NotoSansSC-Regular"
        case (.chinese, .medium):
            fontName = "NotoSansSC-Medium"
        case (.chinese, .bold):
            fontName = "NotoSansSC-Bold"
        }
        
        return .custom(fontName, size: size)
    }
}
