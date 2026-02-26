//
//  CustomerCardView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//

import SwiftUI

struct CustomerCardView: View {
    
    let customer: CustomerModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 45, height: 45)
                .overlay(
                    Text(String(customer.title?.prefix(1) ?? ""))
                        .font(.headline)
                        .foregroundColor(.blue)
                )
            
            // Info
            VStack(alignment: .leading, spacing: 6) {
                Text(customer.title ?? "")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(customer.title ?? "")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 3)
        )
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
