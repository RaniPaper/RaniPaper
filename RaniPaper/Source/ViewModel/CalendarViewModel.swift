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
    
    init(){
        print("✅ CalendarViewModel 생성")
        
        fetchTasks()
        
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
    
}


