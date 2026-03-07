//
//  BaseTextField.swift
//  Learning_SwiftUI
//
//  Created by Chhan Sophearath on 21/1/26.
//

import SwiftUI

struct BaseTextField: View {
    let title: String
    var placeholder: String = "Please Enter"
    var isRequired: Bool = false
    var height: CGFloat = 50
    
    @Binding var text: String
    // Changed to a standard Binding for easier integration
    @Binding var error: String?
    
    private var hasError: Bool {
        error != nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            // Title Layer
            HStack(spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(hasError ? .red : .secondary)
                
                if isRequired {
                    Text("*").foregroundColor(.red)
                }
            }
            .padding(.leading, 2)
            
            // Input Layer
            if #available(iOS 17.0, *) {
                TextField(placeholder, text: $text)
                    .padding(.horizontal, 12)
                    .frame(height: height)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(hasError ? Color.red : Color.clear, lineWidth: 1)
                    )
                // Modern iOS 17+ syntax; use .onChange(of: text) { ... } for older versions
                    .onChange(of: text) {
                        if hasError { error = nil }
                    }
            } else {
                // Fallback on earlier versions
            }
            
            // Error Message
            Text(error ?? " ") // Space prevents height collapse if opacity is 1
                .font(.caption2)
                .foregroundColor(.red)
                .padding(.leading, 4)
                .opacity(hasError ? 1 : 0)
        }
        .animation(.snappy, value: hasError)
    }
}


struct TestTextFieldView: View {
    
    @State private var username = ""
    @State private var usernameError: String? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            BaseTextField(
                title: "Username",
                placeholder: "Enter username",
                isRequired: true,
                text: $username,
                error: $usernameError
            )
            
            
            Button("Submit") {
                if username.isEmpty {
                    usernameError = "Username is required"
                }
            }
        }
        .padding()
    }
}


//extension BaseTextField {
    // Allows you to skip the error binding in the parent view
//    init(title: String, text: Binding<String>, isRequired: Bool = false) {
//        self.title = title
//        self._text = text
//        self.isRequired = isRequired
//        self._error = .constant(nil)
//    }
//}
