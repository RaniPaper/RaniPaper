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
    @Published var isLoading:Bool
    @Published var lockState:LockState
    @Published var isMenuOpen:Bool
    init(){
        self.isLoading = true
        self.isMenuOpen = true
        self.lockState = .locked
    }
    
}
