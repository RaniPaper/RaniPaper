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
    var isPermitted = MyUserDefaults.shared.getValue(key: "notification") as? Bool ?? false
    let content = UNMutableNotificationContent()
    let isRepeat = false
    
    init(){
        print("✅ MyUserNotifications init")
        getPermission()
    }
    
    //Get Permission for notification
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
        isPermitted = MyUserDefaults.shared.getValue(key: "notification") as? Bool ?? false
    }
    
    /// CREAT : TaskModel을 입력 받아 해당 deadline에 알림을 생성합니다.
    /// - Parameter TaskModel: 알림을 받을 TaskModel
    /// UserNotification과 TaskModel은 ID를 공유하게 됩니다.
    func create(_ taskModel: TaskModel){
        if isPermitted{
            content.title = "\(taskModel.title)이(가)  \(taskModel.timeInterval.rawValue)입니다."
            content.body = "알람: " + taskModel.title
            content.sound = UNNotificationSound.default
            var deadLine = taskModel.deadLine
            
            switch taskModel.timeInterval {
            case .fiveMinAgo:
                deadLine = Calendar.current.date(byAdding: .minute, value: -5, to: deadLine)!
            case .tenMinAgo :
                deadLine = Calendar.current.date(byAdding: .minute, value: -10, to: deadLine)!
            case .thirtyMinAgo :
                deadLine = Calendar.current.date(byAdding: .minute, value: -30, to: deadLine)!
                
            case .oneHourAgo :
                deadLine = Calendar.current.date(byAdding: .hour, value: -1, to: deadLine)!
                
            case .twoHourAgo :
                deadLine = Calendar.current.date(byAdding: .hour, value: -2, to: deadLine)!
            case .threeHourAgo :
                deadLine = Calendar.current.date(byAdding: .hour, value: -3, to: deadLine)!
            }
            
            
            
            
            let confirmDeadLine = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: deadLine)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: confirmDeadLine, repeats: isRepeat)
            
            let request = UNNotificationRequest(identifier: taskModel.id, content: content, trigger: trigger)
            
            center.add(request, withCompletionHandler: nil)
            
            print("알람이 설정됩니다. dateComponents: \(taskModel.deadLine) \(taskModel.timeInterval)")
        } else{
            print("푸시 알림이 거부된 상태입니다.")
        }
        
    }
    
    /// READ : 예약된 알림들 목록을 불러옵니다.
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
    
    /// UPDATE : TaskModel을 입력 받아 해당 ID를 갖고 있는 기존 알림을 제거하고 변경된 TaskModel로 알림을 생성합니다.
    /// - Parameter TaskModel: 내용이 변경된 TaskModel
    func update(_ taskModel: TaskModel){
        if isPermitted{
            delete(id: taskModel.id)
            create(taskModel)
        } else{
            print("푸시 알림이 거부된 상태입니다.")
        }
    }
    
    /// DELETE : ID를 입력받아 해당 ID를 가진 예정된 알림을 제거합니다.
    /// - Parameter id: 삭제할 TaskModel의 ID
    func delete(id: String){
        center.removePendingNotificationRequests(withIdentifiers: [id])
        // 해당 ID의 request가 없을 경우 무시
        print("알람이 삭제됩니다. TaskModel ID: \(id)")
    }
    
}
