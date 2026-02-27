//
//  AppNetworkImage.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 26/2/26.
//

import SwiftUI
import Kingfisher

struct AppNetworkImage: View {
    
    let urlString: String?
    var contentMode: SwiftUI.ContentMode = .fill
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        Group {
            if let urlString = urlString,
               let url = URL(string: urlString),
               !urlString.isEmpty {
                
                KFImage(url)
                    .placeholder {
                        loadingView
                    }
                    .retry(maxCount: 2)
                    .cancelOnDisappear(true)
                    .onFailure { _ in
                        print("Image load failed")
                    }
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                
            } else {
                defaultImage
            }
        }
        .cornerRadius(cornerRadius)
        .clipped()
    }
    
    private var loadingView: some View {
        ZStack {
            Color.gray.opacity(0.1)
            ProgressView()
        }
    }
    
    private var defaultImage: some View {
        Image("icon")
            .resizable()
            .scaledToFill()
    }
}
