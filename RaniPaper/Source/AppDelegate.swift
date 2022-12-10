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
    let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        center.delegate = self
        return true
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    // Notification을 클릭하면 실행될 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let application = UIApplication.shared
        
        print("userNotificationCenter Activate")
        
        // Notification Center에 신호를 post
        if application.applicationState == .active{
            print("앱 켜짐")
        }
        
        if application.applicationState == .background{
            print("앱 꺼짐")
            NotificationCenter.default.post(name: NSNotification.Name("Noti Tabbed"), object: nil)
            print("✅ Noti Clicked")
        }
    }
}

// force quit 상황에서는 작동하지 않음
