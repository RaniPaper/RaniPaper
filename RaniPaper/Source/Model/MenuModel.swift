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
    let isSetting: Bool
    
    init(title: String, navigationPath: String, isSetting: Bool){
        id = UUID()
        self.title = title
        self.navigationPath = navigationPath
        self.isSetting = isSetting
    }
}
