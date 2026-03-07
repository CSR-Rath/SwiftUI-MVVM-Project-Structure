//
//  HomeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI
internal import Combine

//struct HomeView: View {
//    @EnvironmentObject var appState: NavigationRouter
//    @EnvironmentObject var languageManager: LanguageManager
//
//    var body: some View {
//        VStack(spacing: 30) {
//
//            Text("welcome_message".localized())
//                .font(.appFont(.bold, size: 15))
//                .foregroundColor(.red)
//
//            Button("Push Notification") {
//                debugLog("Tapped Push")
//                sendLocalNotification()
//            }
//
//            BaseButton(title: "DeepLink") {
//                if let url = URL(string: "deeplinkapp://") {
//                    UIApplication.shared.open(url)
//                }
//            }
//
//            Button("TestField") {
//                appState.push(.baseTextField) // PUSH
//            }
//
//            Button("Scanner") {
//                appState.push(.scanner) // PUSH
//            }
//
//            Button("Drag Drop") {
//                appState.push(.dragdrop) // PUSH
//            }
//
//            Button("Customer List") {
//                appState.push(.customerList) // PUSH
//            }
//
//            Button("Go to Settings") {
//                appState.push(.settings) // PUSH
//            }
//
//            Button("test") {
//                appState.push(.details(productId: "Test"))
//            }
//
//            Button("Switch Language") {
//                languageManager.currentLanguage = (languageManager.currentLanguage == .english) ? .khmer : .english
//            }
//
//            Button("Logout") {
//                appState.switchRoot(.auth)
//            }
//            .foregroundColor(.red)
//        }
//        .navigationTitle("Home")
//    }
//
//}


extension HomeView{
    
    private func sendLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "New Message"
        content.body = "Tap to open Profile"
        content.sound = .default
        
        // 🔥 Important: Add custom data
        content.userInfo = [
            "type": "message"
        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}


import SwiftUI

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

