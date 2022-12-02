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
                MyUserDefaults.shared.setValue(key: settingContent.key, value: settingContent.isOn)
                switch settingContent.soundType {
                case .BGM:
                    MySoundSetting.BGM.updateSoundState(soundType: settingContent.soundType)
                case .SFX:
                    MySoundSetting.SFX.updateSoundState(soundType: settingContent.soundType)
                }
            }
        }
    }
    
    
    init() {
        settingList =
        [SettingContent(soundType: .BGM),
         SettingContent(soundType: .SFX)]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
