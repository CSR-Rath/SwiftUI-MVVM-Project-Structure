//
//  BaseButton.swift
//  Learning_SwiftUI
//
//  Created by Chhan Sophearath on 21/1/26.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}
