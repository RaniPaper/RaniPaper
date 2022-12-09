//
//  AppDelegate.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/08.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        userNotificationCenter.delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    // Notification을 클릭하면 실행될 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Notification Center에 신호를 post
        NotificationCenter.default.post(name: Notification.Name("Noti Tabbed"), object: nil)
        print("✅ Noti Clicked")
        completionHandler()
    }
}
