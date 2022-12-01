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
    
}
