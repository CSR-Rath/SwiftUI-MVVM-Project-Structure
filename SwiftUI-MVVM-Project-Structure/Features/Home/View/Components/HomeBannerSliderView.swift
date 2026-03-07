//
//  BannerSlider.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//


import SwiftUI
internal import Combine
import SwiftUI
import SwiftUI
import Kingfisher

struct HomeBannerSliderView: View {
    
    let banners: [BannerModel]? = [
        BannerModel(id: 1, imageUrl: "https://media.istockphoto.com/id/682211716/photo/mother-and-son-having-fun-on-the-beach.jpg?s=612x612&w=0&k=20&c=rz2C8zFK3muOoFuoEGFVVzJs8yynk2kmovcdr0DNS2U="),
        BannerModel(id: 2, imageUrl: "https://www.shutterstock.com/image-photo/happy-family-young-beautiful-mother-260nw-361087760.jpg"),
        BannerModel(id: 3, imageUrl: "https://www.shutterstock.com/image-photo/happy-family-young-beautiful-mother-260nw-361093184.jpg")
    ]
    
    @State private var currentIndex = 0
    @State private var aspectRatio: CGFloat = 16/9
    
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var safeBanners: [BannerModel] {
        if let banners, !banners.isEmpty {
            return banners
        } else {
            return [BannerModel(id: 0, imageUrl: "imageBanner")]
        }
    }
    
    var body: some View {
        
        TabView(selection: $currentIndex) {
            
            ForEach(Array(safeBanners.enumerated()), id: \.element.id) { index, banner in
                
                BannerItem(
                    imageUrl: banner.imageUrl,
                    onSizeDetected: { ratio in
                        if index == 0 {
                            aspectRatio = ratio
                        }
                    }
                )
                .tag(index)
                .onTapGesture {
                    print("Testing: \(index)")
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .background(Color.grayE0E2Db)
        .cornerRadius(20)
        .onReceive(timer) { _ in
            
            guard safeBanners.count > 1 else { return }
            
            withAnimation {
                currentIndex = (currentIndex + 1) % safeBanners.count
            }
        }
    }
}



struct BannerModel: Identifiable {
    let id: Int
    let imageUrl: String
}



struct BannerItem: View {
    
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
