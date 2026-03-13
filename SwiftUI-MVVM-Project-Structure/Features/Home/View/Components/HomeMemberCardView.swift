//
//  HomeMemberCardView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeMemberCardView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Text("MEMBER ID 000 000 001")
                
                Spacer()
                
                Text("Platinum")
                    .font(.headline)
                    .bold()
                
            }
            
            Text("Point 6,000")
                .font(.headline)
            
        }
        .padding(10)
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(16)
    }
}
