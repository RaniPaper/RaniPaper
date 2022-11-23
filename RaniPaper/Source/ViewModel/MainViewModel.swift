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
    
    init(){
        self.isLoading = false
    }
    
}
