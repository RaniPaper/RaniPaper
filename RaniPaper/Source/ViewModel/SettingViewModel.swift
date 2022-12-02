//
//  SettingViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

final class SettingViewModel: ObservableObject {
    var defaults = UserDefaults.standard
    @Published var settingList: [SettingContent]
    {
        didSet{
            for settingContent in settingList{
                defaults.set(settingContent.isOn, forKey: settingContent.key)
                if settingContent.key == "배경음"{
                    
                }
            }
        }
    }
    
    
    init() {
        settingList =
        [SettingContent(key: "배경음", isOn: defaults.bool(forKey: "배경음")),
            SettingContent(key: "효과음", isOn: defaults.bool(forKey: "효과음"))]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
