//
//  PageView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 24/2/26.
//

import SwiftUI

struct PageView: View {
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            
            TabView(selection: $currentPage) {
                
                FirstPage()
                    .tag(0)
                
                SecondPage()
                    .tag(1)
                
                ThirdPage()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack {
                Button("Back") {
                    guard currentPage > 0 else { return }
                    withAnimation {
                        currentPage -= 1
                    }
                }
                
                Button("Next") {
                    guard currentPage < 2 else { return }
                    withAnimation {
                        currentPage += 1
                    }
                }
            }
            .padding()
        }
    }
}


struct FirstPage: View {
    var body: some View {
        ZStack{
            Color.red
        }
    }
}

struct SecondPage: View {
    var body: some View {
        Color.orange
    }
}

struct ThirdPage: View {
    var body: some View {
        Color.green
    }
}
