//
//  BannerSlider.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 7/3/26.
//

import SwiftUI
internal import Combine

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
                
                BannerAspectRatioView(
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


