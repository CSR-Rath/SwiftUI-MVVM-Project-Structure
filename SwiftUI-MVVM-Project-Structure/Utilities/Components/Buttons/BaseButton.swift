//
//  BaseButton.swift
//  Learning_SwiftUI
//
//  Created by Chhan Sophearath on 21/1/26.
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
                            Image(icon)
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
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isLoading)
    }
}


struct BaseButtonView: View {

    enum Style {
        case normal
        case icon
    }

    let title: String
    var icon: String? = nil
    var style: Style = .normal
    var size: CGFloat = 44

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .white
    var isLoading: Bool = false

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    content
                }
            }
            .frame(
                width: style == .icon ? size : nil,
                height: size
            )
            .background(backgroundColor.opacity(isLoading ? 0.7 : 1))
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style == .icon ? size / 2 : 12))
        }
        .disabled(isLoading)
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .normal:
            HStack(spacing: 8) {
                if let icon { Image(icon) }
                Text(title).fontWeight(.bold)
            }
            .padding(.horizontal)

        case .icon:
            if let icon {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            }
        }
    }
}
