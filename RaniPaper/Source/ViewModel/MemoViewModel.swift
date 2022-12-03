//
//  MemoViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

final class MemoViewModel:ObservableObject {
    @Published var isDropDown:Bool = false
    @Published var wayToShow:String = "크게보기"
    @Published var deleteMode:Bool = false
    @Published var showDatePicker:Bool = false
    @Published var showEditView:Bool = false
    @Published var memos:[MemoModel] = []
    
    var existMemo:MemoModel?
    var trashSet:Set<String>?
    
    init()
    {
        print("✅ MemoViewModel 생성")
        trashSet = Set<String>()
        fetchMemos()
    }
    
    func fetchMemos(){
        let result = MyFileManager.shared.contentsOfDirectory(at: .memo)
        
        switch result {
        case .success(let date):
            memos = date.map{$0 as! MemoModel}.sorted(by: {
                $0.date > $1.date
            })
            print(memos)

        case .failure(let error):
            print(error.errorDescription)
        }
    }
    
    func deleteMemos(trash:Set<String>) ->Bool {
        
        var success:Bool = true
        for id in trash{
            
            success = deleteMemo(id)
        }
        
        return success
    }
    
    func deleteMemo(_ id: String) -> Bool {
        let result = MyFileManager.shared.delete(at: .memo, fileName: "memo-\(id).json")
        
        switch result {
        case .success():
            return true
        case .failure(let error):
            print(error.errorDescription)
            return false
        }
        
    }
    
    deinit{
        print("❌ MemoViewModel 소멸")
        trashSet = nil
        existMemo = nil
    }
}
