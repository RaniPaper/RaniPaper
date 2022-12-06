//
//  MainViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import Foundation
import Combine
import SwiftUI

final class MainViewModel : ObservableObject {
    @Published var isLoading: Bool
    @Published var selection: ViewSelection

    init(){
        self.isLoading = true
        self.selection = .home
        
        print("✅ MainViewModel 생성")
    }
    
    deinit{
        print("❌ MainViewModel 소멸")
    }
    
}
