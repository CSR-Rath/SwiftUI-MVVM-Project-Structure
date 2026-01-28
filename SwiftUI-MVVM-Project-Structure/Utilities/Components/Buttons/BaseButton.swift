//
//  BaseButton.swift
//  Learning_SwiftUI
//
//  Created by Design_PC on 21/1/26.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    var icon: String? = nil
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var isLoading: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack { // Use ZStack to keep the height consistent
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    HStack(spacing: 8) {
                        if let icon = icon {
                            Image(systemName: icon)
                        }
                        Text(title)
                            .fontWeight(.bold)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .foregroundColor(foregroundColor)
            .background(isLoading ? backgroundColor.opacity(0.7) : backgroundColor)
            // Clip the background into a capsule or rounded rectangle
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isLoading)
    }
}
