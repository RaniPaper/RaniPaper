//
//  SettingViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

final class SettingViewModel: ObservableObject {
    @Published var settingList: [String]
//    @Published var isSoundOn = UserDefaults.standard.bool(forKey: "배경음")
    
    init() {
        settingList = ["배경음",
                       "효과음",
                       "설정3",
                       "설정4"]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
