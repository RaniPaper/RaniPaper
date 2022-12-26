//
//  CalendarViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

final class CalendarViewModel: ObservableObject{
    
    @Published var currentDate: Date = Date()
    @Published var showEdit: Bool = false
    @Published var tasks: [TaskModel] = []
    @Published var randomInt:Int = 0
    

    let noTaskMessages:[String] = ["할 일 없는 날! 낮잠이라도 자볼까요?"
                                   ,"할 일이 없네요! 여유를 즐기세요!"
                                   ,"할 일이 없군요. 오늘은 쉬는 날!"
                                   ,"오늘 할 일이 없나요? 더블체크 필수!"
                                   ,"할 일이 없어요. 잊은건 없으시죠?"]
    
   
    
    init(){
        print("✅ CalendarViewModel 생성")
        fetchTasks()
        randomInt = Int.random(in: 0..<5)
        
    }
    
    deinit{
        print("❌ CalendarViewModel 소멸")
    }
    
    func fetchTasks() {
        let result = MyFileManager.shared.contentsOfDirectory(at: .diary)
        switch result {
        case .success(let data):
            tasks = data.map { $0 as! TaskModel }.sorted(by: { $0.deadLine < $1.deadLine })
        case .failure(let error):
            print(error.errorDescription)
        }
    }
    
    func deleteTask(id: String) -> Bool {
        let result = MyFileManager.shared.delete(at: .diary, fileName: "task-\(id).json")
        //알림 삭제
        MyUserNotifications.shared.delete(id: id)
        switch result {
        case .success():
            return true
        case .failure(let error):
            print(error.errorDescription)
            return false
        }
    }
    
}


