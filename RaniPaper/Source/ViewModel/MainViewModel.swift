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
    @Published var selection: ViewSelection?
    @Published private(set) var keyboardHeight: CGFloat = 0
    private var subscription: AnyCancellable?
    private let keyboardWillShow =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { output in
            (output.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            // 유저 정보 맵에서 keyboard 높이를 얻는다.
        }

    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero}

    init(){
        self.isLoading = true
        self.lockState = .locked
        self.selection = .home
        subscription = Publishers.Merge(keyboardWillShow, keyboardWillHide)
                   .subscribe(on: DispatchQueue.main) // UI 변화 이므로 메인. 쓰레드
                   .assign(to: \.self.keyboardHeight, on: self)
        
        print("✅ MainViewModel 생성")
    }
    
    deinit{
        print("❌ MainViewModel 소멸")
    }
    
}
