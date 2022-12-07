//
//  Enum.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import Foundation
import SwiftUI

enum LockState{
    case locked
    case viichan
    case rani
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.size.height
}

enum Menu {
    static let minOffset = ScreenSize.width
    static let maxOffset = ScreenSize.width * 0.5
    static let threshold = Menu.maxOffset * 1.3
    static let openEdge = ScreenSize.width * 0.85
}

enum ViewSelection: CaseIterable {
    case home
    case diary
    case memo
    case setting
    case info
    case credit
}

enum SoundType: String{
    case BGM = "배경음", SFX = "효과음", ALARM = "알람"
    //case Alarm:
}
