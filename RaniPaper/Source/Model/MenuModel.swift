//
//  MenuModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/25.
//

import Foundation
import SwiftUI

class MenuContent: ObservableObject, Identifiable {
    let id: UUID
    let title: String
    let navigationPath: String
    let isUnder: Bool
    let isSetting: Bool
    
    init(title: String, navigationPath: String, isUnder: Bool = false, isSetting: Bool = false){
        id = UUID()
        self.title = title
        self.navigationPath = navigationPath
        self.isUnder = isUnder
        self.isSetting = isSetting
    }
}
