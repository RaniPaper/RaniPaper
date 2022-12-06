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
    
    func update(_ taskModel: TaskModel){
        if permission{
            delete(id: taskModel.id)
            create(taskModel)
        } else{
            print("푸시 알림이 거부된 상태입니다.")
        }
    }
    
    func delete(id: String){
        center.removePendingNotificationRequests(withIdentifiers: [id])
        print("알람이 삭제됩니다. TaskModel ID: \(id)")
    }
    
}
