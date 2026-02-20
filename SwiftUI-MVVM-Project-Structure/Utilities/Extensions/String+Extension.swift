//
//  String+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

internal import Foundation

extension Optional where Wrapped == String {
    var isNotBlank: Bool {
        self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }
}
