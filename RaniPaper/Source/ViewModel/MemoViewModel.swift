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
    
    
    init()
    {
        print("✅ MemoViewModel 생성")
    }
    
    deinit{
        print("❌ MemoViewModel 소멸")
    }
}
