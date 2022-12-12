//
//  SettingViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

final class SettingViewModel: ObservableObject {
    @Published var soundSettingList: [SoundSettingModel]
    {
        didSet{
            for soundSettingModel in soundSettingList{
                MyUserDefaults.shared.setValue(key: soundSettingModel.key, value: soundSettingModel.isOn)
                for instance in MySoundSetting.getInstance(soundType: soundSettingModel.soundType){
                    instance.updateSoundState(soundType: soundSettingModel.soundType)
                }
            }
        }
    }
    @Published var settingList: [SettingModel]
    
    
    init() {
        soundSettingList =
        [SoundSettingModel(soundType: .BGM),
         SoundSettingModel(soundType: .SFX),
         SoundSettingModel(soundType: .ALARM)]
        
        settingList =
        [SettingModel(content: "비밀번호 설정", action: .setPassword, section: .privacy),
         SettingModel(content: "데이터 내보내기", action: .exportData, section: .data),
         SettingModel(content: "데이터 초기화", action: .resetData, section: .data),
         SettingModel(content: "RaniPaper 사용법", action: .showOnBoard, section: .etc)
        ]
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
