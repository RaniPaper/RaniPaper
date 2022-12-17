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
    @Published var isAnimationOn: Bool
    {
        didSet{
            MyUserDefaults.shared.setValue(key: "isAnimationOn", value: isAnimationOn)
        }
    }
    
    
    init() {
        soundSettingList =
        [SoundSettingModel(soundType: .BGM),
         SoundSettingModel(soundType: .SFX),
         SoundSettingModel(soundType: .ALARM)]
        
        settingList =
//        [SettingModel(content: "비밀번호 설정", action: .setPassword, section: .privacy),
//         SettingModel(content: "데이터 초기화", action: .resetData, section: .data),
         [SettingModel(content: "사용법", action: .showOnBoard, section: .etc),
         SettingModel(content: "개발자 웹사이트", action: .showWebsite, section: .etc),
         SettingModel(content: "문의하기", action: .ask, section: .etc)
        ]
        
        if let value = MyUserDefaults.shared.getValue(key: "isAnimationOn"){
            isAnimationOn = value as! Bool
        } else{
            isAnimationOn = true
        }
        
        print("✅ SettingViewModel 생성")
    }
    
    deinit {
        print("❌ SettingViewModel 소멸")
    }
}
