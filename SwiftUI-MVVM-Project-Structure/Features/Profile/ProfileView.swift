//
//  ProfileView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    let userId: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile: \(userId)")
                .font(.largeTitle)
                .bold()

            Button("Pop (Back)") {
                appState.pop()
            }

            Button("Pop to Home") {
                appState.popToRoot()
            }
            
            Button("Push") {
                sendLocalNotification()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true) // hide default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    print("Menu tapped")
                    appState.pop()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
}

extension ProfileView{
    
   private func sendLocalNotification() {

        let content = UNMutableNotificationContent()
        content.title = "New Message"
        content.body = "Tap to open Profile"
        content.sound = .default
        
        // 🔥 Important: Add custom data
        content.userInfo = [
            "type": "profile"
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



