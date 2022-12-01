//
//  SettingViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

final class SettingViewModel: ObservableObject {
    @Published var settingList: [SettingContent]
    {
        didSet{
            for settingContent in settingList{
                UserDefaults.standard.set(settingContent.isOn, forKey: settingContent.key)
            }
        }
    }
    
    
    init() {
        settingList =
            [SettingContent(key: "배경음", isOn: UserDefaults.standard.bool(forKey: "배경음")),
            SettingContent(key: "효과음", isOn: UserDefaults.standard.bool(forKey: "효과음"))]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
