//
//  View+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//

import SwiftUI

extension View {
    
    // MARK: - Customer navigationBarBackButton
    func menuToolbar(appState: NavigationRouter) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        appState.pop()
                    } label: {
                        Image("icBackNav")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
            }
    }
}


extension View{
    
     func sendLocalNotification() {
        
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


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
