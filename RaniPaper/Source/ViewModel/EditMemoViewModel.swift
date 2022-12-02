//
//  EditMemoViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/02.
//

import Foundation

final class EditMemoViewModel:ObservableObject{
    
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
    
}
