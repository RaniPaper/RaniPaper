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
    let key: String
    var isOn: Bool
    
    init(key: String, isOn: Bool) {
        id = UUID()
        self.key = key
        self.isOn = isOn
    }
}
