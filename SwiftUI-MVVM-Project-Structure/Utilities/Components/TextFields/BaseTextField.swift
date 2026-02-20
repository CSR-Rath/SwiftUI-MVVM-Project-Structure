//
//  BaseTextField.swift
//  Learning_SwiftUI
//
//  Created by Chhan Sophearath on 21/1/26.
//

import SwiftUI


import SwiftUI

struct BaseTextField: View {
    let title: String
    var placeholder: String = "Please Enter"
    var isRequired: Bool = false
    var height: CGFloat = 50
    
    @Binding var text: String
    var error: Binding<String?>? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 1. Title Area
            HStack(spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(error?.wrappedValue == nil ? .secondary : .red)
                
                if isRequired {
                    Text("*").foregroundColor(.red)
                }
            }
            .padding(.leading, 2)
            
            // 2. Input Area
            TextField(placeholder, text: $text)
                .padding(.horizontal, 12)
                .frame(height: height)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(error?.wrappedValue == nil ? Color.clear : Color.red, lineWidth: 1)
                )
                .onChange(of: text) { _ in
                    // Logic: If user types, clear the error immediately
                    if error?.wrappedValue != nil {
                        error?.wrappedValue = nil
                    }
                }
            
            // 3. Error Message Area
            if let errorMessage = error?.wrappedValue {
                Text(errorMessage)
                    .font(.caption2)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
        .animation(.default, value: error?.wrappedValue)
    }
}
