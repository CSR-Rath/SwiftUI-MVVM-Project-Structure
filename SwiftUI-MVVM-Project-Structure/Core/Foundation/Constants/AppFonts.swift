//
//  AppFonts.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

import SwiftUI

enum AppFonts {
    
    // MARK: - Headings
    static func largeTitle() -> Font {
        .system(size: 32, weight: .bold)
    }
    
    static func title() -> Font {
        .system(size: 24, weight: .semibold)
    }
    
    static func headline() -> Font {
        .system(size: 18, weight: .semibold)
    }
    
    // MARK: - Body
    static func body() -> Font {
        .system(size: 16, weight: .regular)
    }
    
    static func caption() -> Font {
        .system(size: 14, weight: .regular)
    }
}
