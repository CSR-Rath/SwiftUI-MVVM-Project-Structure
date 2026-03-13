//
//  BannerAspectRatioView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 12/3/26.
//

import SwiftUI
import Kingfisher

struct BannerAspectRatioView: View {
    
    let imageUrl: String
    let defaultImageName: String? = "imageBanner"
    var onSizeDetected: ((CGFloat) -> Void)? = nil
    
    @State private var loadFailed = false
    
    var body: some View {
        
        Group {
            
            if loadFailed || imageUrl.isEmpty {
                
                Image(defaultImageName ?? "imageBanner")
                    .resizable()
                    .scaledToFit()
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                let ratio = geo.size.width / geo.size.height
                                onSizeDetected?(ratio)
                            }
                        }
                    )
                
            } else {
                
                KFImage(URL(string: imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .onSuccess { result in
                        let size = result.image.size
                        let ratio = size.width / size.height
                        onSizeDetected?(ratio)
                    }
                    .onFailure { _ in
                        loadFailed = true
                    }
                    .resizable()
                    .scaledToFit()
                
            }
        }
        .clipped()
    }
}



struct OTPView: View {
    
    @State private var otp: [String] = Array(repeating: "", count: 6)
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            ForEach(0..<6, id: \.self) { index in
                
                TextField("", text: $otp[index])
                    .frame(width: 45, height: 45)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
            }
        }
        .padding()
    }
}
