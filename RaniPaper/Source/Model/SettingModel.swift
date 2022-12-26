//
//  SettingModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

struct SoundSettingModel: Identifiable {
    let id: UUID
    let soundType: SoundType
    let key: String
    var isOn: Bool
    
    init(soundType: SoundType) {
        id = UUID()
        self.soundType = soundType
        self.key = self.soundType.rawValue
        
        if let value = MyUserDefaults.shared.getValue(key: self.key){
            self.isOn = value as! Bool
        } else {
            self.isOn = true
        }
    }
    
    func getUIName() -> String{
        switch self.soundType{
        case .SFX:
            return "SFX"
        case .BGM:
            return "BGM"
        case .ALARM:
            return "alarm"
        }
    }
}

struct SettingModel: Identifiable{
    let id: UUID
    let content: String
    let action: Action
    let section: Section
    
    init(content: String, action: Action, section: Section){
        id = UUID()
        self.content = content
        self.action = action
        self.section = section
    }
}

extension SettingModel{
    enum Action{
        case setPassword
        case exportData
        case resetData
        case showOnBoard
        case showWebsite
        case ask
    }
    
    enum Section: String, CaseIterable{
//        case privacy = "개인정보"
//        case data = "데이터 처리"
        case etc = "기타"
    }
}
