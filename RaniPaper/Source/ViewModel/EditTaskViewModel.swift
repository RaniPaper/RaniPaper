//
//  EditTaskViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/29.
//

import SwiftUI
import Combine

final class EditTaskViewModel:ObservableObject{
    var taskId: String?
    @Published var taskTitle:String = ""
    @Published var taskDeadLine:Date = Date()
    @Published var taskColor:String = "ine"
    @Published var taskTicket:String = "우왁굳"
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    
    private var subscription = Set<AnyCancellable>()
    
    private let keyboardWillShow =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { output in
            (output.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            // 유저 정보 맵에서 keyboard 높이를 얻는다.
        }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero}
    
    
    
    init(){
        print("✅ EditTaskViewModel 생성")
        Publishers.Merge(keyboardWillShow, keyboardWillHide)
                .subscribe(on: DispatchQueue.main) // UI 변화 이므로 메인. 쓰레
                .sink(receiveValue: { [weak self] keyboardHeight in
                    guard let self = self else { return }
                    self.keyboardHeight = keyboardHeight
                })
                .store(in: &subscription)
                  // .assign(to: \.keyboardHeight, on:  self)
    }
    
    deinit{
        print("❌ EditTaskViewModel 소멸")
    
    }
    
    func save() -> Bool {
        let taskModel = TaskModel(title: taskTitle, deadLine: taskDeadLine, color: taskColor, ticket: taskTicket)
        let result = MyFileManager.shared.create(at: .diary, fileName: "task-\(taskModel.id).json", taskModel)
        
        switch result {
        case .success():
            return true
        case .failure(let error):
            print(error.errorDescription)
            return false
        }
        
    }
    
    func update() -> Bool {
        // 기존 task 편집시엔 이미 taskId가 있으므로 해당 taskId로 저장, 신규면 새 UUID
        let taskModel = TaskModel(id: taskId ?? UUID().uuidString, title: taskTitle, deadLine: taskDeadLine, color: taskColor, ticket: taskTicket)
        let result = MyFileManager.shared.update(at: .diary, fileName: "task-\(taskModel.id).json", taskModel)
        
        switch result {
        case .success():
            return true
        case .failure(let error):
            print(error.errorDescription)
            return false
        }
        
    }
    
}
