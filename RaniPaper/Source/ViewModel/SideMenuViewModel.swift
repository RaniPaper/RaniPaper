//
//  SideMenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/28.
//

import Foundation
import SwiftUI

final class SideMenuViewModel: ObservableObject {
    @Published var menuList: [MenuContent]
    @Published var settingList: [String]
    @Published var isBgmOn: Bool
    
    init(){
        menuList = [MenuContent(title: "홈",                                                   viewSelection: .home),
                    MenuContent(title: "다이어리", viewSelection: .diary),
                    MenuContent(title: "기록", viewSelection: .memo),
                    MenuContent(title: "설정", viewSelection: .home, isSetting: true),
                    MenuContent(title: "앱정보", viewSelection: .info, isUnder: true),
                    MenuContent(title: "크레딧", viewSelection: .credit, isUnder: true)]
        settingList = ["배경음",
                         "효과음",
                         "알람"]
        isBgmOn = true
        
        print("✅ SideMenuViewModel 생성")
    }
    deinit {
        print("❌ SideMenuViewModel 소멸")
    }
}
