//
//  CustomTabView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 25/2/26.
//

import SwiftUI


struct MainTabbedView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                ProfileView(userId: "")
                    .tag(1)
                
                ProfileView(userId: "")
                    .tag(2)
                ProfileView(userId: "")
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            
                            CustomTabItem(
                                imageName: item.iconName,
                                title: item.title,
                                isActive: (selectedTab == item.rawValue)
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 85)
            .background(.gray)
        }
        .ignoresSafeArea(.all)
    }
}

struct CustomTabItem: View {
    
    let imageName: String
    let title: String
    let isActive: Bool
    
    @State private var showFlash = false
    
    var body: some View {
        VStack(alignment: .center,spacing: 5) {
            
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .orange)
                .frame(width: 28, height: 28)
                .background(Color.red)
            
            Text(title)
                .font(.system(size: 14))
                .fontWeight(isActive ? .bold : .regular)
                .foregroundColor(isActive ? .black : .orange)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(5)
        .background(showFlash ? Color.purple : Color.clear)
        .onChange(of: isActive) { newValue in
            if newValue {
                showFlash = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showFlash = false
                }
            }
        }
    }
}
