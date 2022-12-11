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
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        center.delegate = self
        print("willFinishLaunchingWithOptions")
        return true
    }
}

// Notification 관련 extension
extension AppDelegate: UNUserNotificationCenterDelegate{
    // Notification을 클릭하면 실행될 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let application = UIApplication.shared
        
        print("Execute didReceive")
        
        // Notification Center에 신호를 post
        if application.applicationState == .active{
            print("앱 켜짐")
        }
        
        if application.applicationState == .background{
            print("앱 꺼짐")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("Noti Tabbed"), object: nil)
        print("✅ Noti Clicked")
    }
    
    // app이 forground 상태일 때 실행할 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Execute willPresent")
        completionHandler([.banner, .sound])
    }
}

// force quit 상황에서는 작동하지 않음
