//
//  Button+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

extension Button {
    
    func baseSizeButton(
        font: Font = .headline,
        textColor: Color = .white,
        backgroundColor: Color = .blue
    ) -> some View {
        
        self
            .font(font)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .cornerRadius(8)
    }
}
