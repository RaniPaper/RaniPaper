//
//  Enum.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import Foundation
import SwiftUI

enum UserType: String {
    case none = "none"
    case viichan = "viichan"
    case fan = "fan"
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.size.height
}

enum SafeAreaInsets {
    private static let insets = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows.first{$0.isKeyWindow }?.safeAreaInsets
    
    static let top = insets?.top ?? 0
    static let bottom = insets?.bottom ?? 0
}

enum Menu {
    static let minOffset = ScreenSize.width
    static let maxOffset = ScreenSize.width * 0.5
    static let openThreshold = Menu.maxOffset * 1.7
    static let closeThreshold = Menu.maxOffset * 1.2
    static let openEdge = ScreenSize.width * 0.95
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

enum TimeIntervals: String,Codable{
    case fiveMinAgo = "5분 전",
    tenMinAgo = "10분 전",
    thirtyMinAgo = "30분 전",
    oneHourAgo = "1시간 전",
    twoHourAgo = "2시간 전",
    threeHourAgo = "3시간 전"
}
