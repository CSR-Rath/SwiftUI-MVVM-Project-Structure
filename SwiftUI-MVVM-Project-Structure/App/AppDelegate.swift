//
//  AppDelegate.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 20/2/26.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate{
    
    var appState: NavigationRouter?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        configureGoogleMaps()
        configureFirebase()
        requestNotificationPermission(application: application)
        return true
    }
    
    
    // Configure google maps key
    private func configureGoogleMaps(){
        GMSServices.provideAPIKey("AIzaSyDSXrwu6JBuY6VfJfjCcXDdOp2PqIwbGbk")
    }
    
    // Configure firebase messaging
    private func configureFirebase() {
          FirebaseApp.configure()
          Messaging.messaging().delegate = self
      }
    
    // Request permision notification
    private func requestNotificationPermission(application: UIApplication){
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
}


// MARK: - Remark we need appple developer to handle APNs
extension AppDelegate: MessagingDelegate{
    // Get device token
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token:", token)
    }
    
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {

        print("FCM Token:", fcmToken ?? "")
    }
}




// MARK: - Handle notification
extension AppDelegate: UNUserNotificationCenterDelegate{

    // Notification will present
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .sound])
    }
    
    // Notification did receive
    @MainActor
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {

        let userInfo = response.notification.request.content.userInfo
        handleNotification(userInfo: userInfo)
    }
    
    private func handleNotification(userInfo: [AnyHashable: Any]) {
        guard let typeString = userInfo["type"] as? String,
              let type = AppNotificationType(rawValue: typeString) else {
            return
        }
        
        print("====> type: \(type)")

        switch type {
        case .message:
            appState?.push(.profile(userId: "Test NO"))
        case .order:
            appState?.push(.settings)
        default:
            break
        }
    }
}
