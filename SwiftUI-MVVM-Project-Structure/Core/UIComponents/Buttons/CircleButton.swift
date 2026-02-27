//
//  CircleButton.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI

struct CircleButton: View {
    
    let icon: String
    var iconSize: CGFloat = 20
    var size: CGFloat = 36
    var backgroundColor: Color = .gray
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}
