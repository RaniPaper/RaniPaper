//
//  MyUserNotification.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/06.
//

import Foundation
import UserNotifications

final class MyUserNotifications {
    static let shared = MyUserNotifications()
    let center = UNUserNotificationCenter.current()
    var permission = MyUserDefaults.shared.getValue(key: "notification") as! Bool
    let content = UNMutableNotificationContent()
    let isRepeat = false
    
    init(){
        print("✅ MyUserNotifications init")
        getPermission()
    }
    
    //Get Permission
    func getPermission(){
        center.requestAuthorization(options: [.badge, .sound, .alert]){(granted, error) in
            if granted{
                print("✅ 사용자가 푸시 알림을 승인합니다.")
                DispatchQueue.main.async{
                    MyUserDefaults.shared.setValue(key: "notification", value: granted)
                }
            } else{
                if let theError = error{
                    MyUserDefaults.shared.setValue(key: "notification", value: granted)
                    print("🔥 사용자가 푸시 알림을 거부합니다. \(theError.localizedDescription)")
                }
            }
        }
        permission = MyUserDefaults.shared.getValue(key: "notification") as! Bool
    }
    
    // Create UserNotification Request
    func create(_ taskModel: TaskModel){
        if permission{
            content.title = taskModel.title
            content.body = "알람: " + taskModel.title
            content.sound = UNNotificationSound.default
            
            let deadLine = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: taskModel.deadLine)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: deadLine, repeats: isRepeat)
            
            let request = UNNotificationRequest(identifier: taskModel.id, content: content, trigger: trigger)
            
            center.add(request, withCompletionHandler: nil)
            
            print("알람이 설정됩니다. dateComponents: \(deadLine)")
        } else{
            print("푸시 알림이 거부된 상태입니다.")
        }
        
    }
    
    // Read Pending Notification Request
    // 사용처가 확실해지면 리턴 형태 수정 예정, 현재 테스트용
    func read(){
        center.getPendingNotificationRequests(completionHandler:{ requests in
                for request in requests{
                    if let theRequest = request.trigger{
                        print(theRequest)
                    } else{
                        print("예정된 알림이 없습니다")
                    }
            }
        })
    }
    
    // Update Notification Request
    // 기존 알림 제거하고 새로운 알림 생성
    func update(_ taskModel: TaskModel){
        if permission{
            delete(id: taskModel.id)
            create(taskModel)
        } else{
            print("푸시 알림이 거부된 상태입니다.")
        }
    }
    
    // Delete Notification Request
    func delete(id: String){
        center.removePendingNotificationRequests(withIdentifiers: [id])
        // 해당 ID의 request가 없을 경우 무시
        print("알람이 삭제됩니다. TaskModel ID: \(id)")
    }
    
}
