//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var menuList: [MenuContent] = [MenuContent(title: "홈",                                                   viewSelection: .home),
                                              MenuContent(title: "다이어리", viewSelection: .diary),
                                              MenuContent(title: "기록", viewSelection: .memo),
                                              MenuContent(title: "설정", viewSelection: .home, isSetting: true),
                                              MenuContent(title: "앱정보", viewSelection: .home, isUnder: true),
                                              MenuContent(title: "크레딧", viewSelection: .home, isUnder: true)]
    @Published var Offset: CGFloat = Menu.minOffset
    @Published var isOpen: Bool = false
    @Published var selection: ViewSelection = .home
    
    init()
    {
        print("✅ MenuViewModel 생성")
    }
    
    deinit{
        print("❌ MenuViewModel 소멸")
    }
}
