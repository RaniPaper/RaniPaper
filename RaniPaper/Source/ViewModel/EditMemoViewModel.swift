//
//  EditMemoViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/02.
//

import Foundation

final class EditMemoViewModel:ObservableObject{
    
    var memoId:String?
    @Published var nowDate:Date = Date()
    @Published var title:String = ""
    @Published var content:String = ""
    

    init()
    {
        print("✅ EditMemoViewModel 생성")
    }
    
    deinit{
        print("❌ EditMemoViewModel 소멸")
    }
    
    
    func save() -> Bool {
        let memoModel = MemoModel(date:nowDate,title:title,content: content )
        let result = MyFileManager.shared.create(at: .memo, fileName: "memo-\(memoModel.id).json", memoModel)
        
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
        let memoModel = MemoModel(date:nowDate,title:title,content: content)
        let result = MyFileManager.shared.update(at: .memo, fileName: "memo-\(memoModel.id).json", memoModel)
        
        switch result {
        case .success():
            return true
        case .failure(let error):
            print(error.errorDescription)
            return false
        }
        
    }

    
}
