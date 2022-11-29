//
//  CalendarViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

final class CalendarViewModel: ObservableObject{
    
    @Published var currentDate: Date = Date()
    @Published var showEdit:Bool = false
    init(){
        print("✅ CalendarViewModel 생성")
    }
    
    deinit{
        print("❌ CalendarViewModel 소멸")
    }
}


