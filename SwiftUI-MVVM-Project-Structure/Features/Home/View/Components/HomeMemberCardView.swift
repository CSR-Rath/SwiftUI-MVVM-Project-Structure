//
//  HomeMemberCardView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI

struct HomeMemberCardView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("MEMBER ID 000 000 001")
            
            Text("Point 6,000")
                .font(.headline)
//            
//            Spacer()
//                .background(Color.red)
            
            HStack {
                Spacer()
                
                Text("Platinum")
                    .font(.headline)
                    .bold()
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(16)
    }
}
