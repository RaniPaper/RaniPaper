//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var Offset: CGFloat = Menu.minOffset
    @Published var isOpen: Bool = false
    @Published var isSettingOn: Bool = false
    @Published var selection: ViewSelection = .home
    @Published var menuList = [MenuContent(title: "홈",                                                   viewSelection: .home),
                               MenuContent(title: "다이어리", viewSelection: .diary),
                               MenuContent(title: "기록", viewSelection: .memo),
                               MenuContent(title: "설정", viewSelection: .setting, isSetting: true),
                               MenuContent(title: "앱정보", viewSelection: .info, isUnder: true),
                               MenuContent(title: "크레딧", viewSelection: .credit, isUnder: true)]
    
    init()
    {
        print("✅ MenuViewModel 생성")
    }
    
    deinit{
        print("❌ MenuViewModel 소멸")
    }
}
