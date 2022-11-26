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
    let viewSelection: ViewSelection
    let isUnder: Bool
    let isSetting: Bool
    
    init(title: String, viewSelection: ViewSelection, isUnder: Bool = false, isSetting: Bool = false){
        id = UUID()
        self.title = title
        self.viewSelection = viewSelection
        self.isUnder = isUnder
        self.isSetting = isSetting
    }
}
