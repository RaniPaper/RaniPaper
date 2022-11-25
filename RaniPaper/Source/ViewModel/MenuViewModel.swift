//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var menuList: [MenuContent] = [MenuContent(title: "홈",                                                   navigationPath: "홈"),
                                              MenuContent(title: "다이어리", navigationPath: "다이어리"),
                                              MenuContent(title: "기록", navigationPath: "기록"),
                                              MenuContent(title: "설정", navigationPath: "설정", isSetting: true),
                                              MenuContent(title: "앱정보", navigationPath: "앱정보", isUnder: true),
                                              MenuContent(title: "크레딧", navigationPath: "크레딧", isUnder: true)]
    @Published var Offset: CGFloat = Menu.minOffset
    @Published var isOpen: Bool = false
    
    init()
    {
        print("✅ MenuViewModel 생성")
    }
    
    deinit{
        print("❌ MenuViewModel 소멸")
    }
}
