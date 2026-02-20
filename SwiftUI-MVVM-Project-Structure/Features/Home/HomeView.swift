//
//  HomeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: NavigationRouter

    var body: some View {
        VStack(spacing: 30) {
            Text("Home")
                .font(.largeTitle)
                .bold()

            Button("Push Notification") {
                print("Tapped Push")
                sendLocalNotification()
            }

            
            Button("Go to Settings") {
                appState.push(.settings) // PUSH
            }

            Button("Go to profile") {
                appState.push(.profile(userId: " A001"))
            }
            
            Button("test") {
                appState.push(.details(productId: "Test"))
            }


            Button("Logout") {
                appState.switchToAuth()
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}

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
