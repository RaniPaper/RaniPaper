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
    static let maxOffset = ScreenSize.width * 0.3
    static let threshold = ScreenSize.width * 0.65
}

