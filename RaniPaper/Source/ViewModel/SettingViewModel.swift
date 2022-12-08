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
                MyUserDefaults.shared.setValue(key: settingContent.key, value: settingContent.isOn)
                for instance in MySoundSetting.getInstance(soundType: settingContent.soundType){
                    instance.updateSoundState(soundType: settingContent.soundType)
                }
            }
        }
    }
    
    
    init() {
        settingList =
        [SettingContent(soundType: .BGM),
         SettingContent(soundType: .SFX),
         SettingContent(soundType: .ALARM)]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
