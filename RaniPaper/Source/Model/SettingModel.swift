//
//  SettingModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import Foundation
import SwiftUI

struct SettingContent: Identifiable {
    let id: UUID
    let soundType: SoundType
    let key: String
    var isOn: Bool
    
    init(soundType: SoundType) {
        id = UUID()
        self.soundType = soundType
        self.key = self.soundType.rawValue
        self.isOn = MyUserDefaults.shared.getValue(key: self.key) as! Bool
    }
}
