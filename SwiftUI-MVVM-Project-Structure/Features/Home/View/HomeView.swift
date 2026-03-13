//
//  HomeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI
internal import Combine

struct HomeView: View {

    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HomeHeaderView()
            
            ScrollView() {
                VStack(spacing: 16) {
                    HomeUpgradeBannerView()
                        .padding(.top, 16)
                        .padding(.horizontal)
                    
                    HomeMemberCardView()
                        .padding(.horizontal)
                       
                    
                    HomeFeatureCardView()
                        .padding(.horizontal)
                        
                    
                    HomeCategoryGridView()
                        .padding(.horizontal)
                        
                    
                    HomeBannerSliderView()
                        .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 120)
                }
            }
            .padding(0)
            
            
            .refreshable {
                
            }
        }
    }
}




struct TestView: View {
    
    
    var body: some View {
        
    }
}
