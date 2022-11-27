//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var Offset: CGFloat = Menu.minOffset
    @Published var isOpen: Bool = false
    @Published var selection: ViewSelection = .home
    
    init()
    {
        print("✅ MenuViewModel 생성")
    }
    
    deinit{
        print("❌ MenuViewModel 소멸")
    }
}
