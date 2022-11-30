//
//  KeyboardHandler.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/29.
//

import SwiftUI
import Combine


final class KeyboardHander:ObservableObject{
    @Published private(set) var keyboardHeight: CGFloat = 0
    private var subscription = Set<AnyCancellable>()
    private let keyboardWillShow =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { output in
            (output.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            // 유저 정보 맵에서 keyboard 높이를 얻는다.
        }

    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero}
    
    init()
    {
        print("✅ KeyboadHanfler")
        Publishers.Merge(keyboardWillShow, keyboardWillHide)
                .subscribe(on: DispatchQueue.main) // UI 변화 이므로 메인. 쓰레
                .sink(receiveValue: { [weak self] keyboardHeight in
                    guard let self = self else { return }
                    self.keyboardHeight = keyboardHeight
                })
                .store(in: &subscription)
                  // .assign(to: \.keyboardHeight, on:  self)
        
    }
    
    deinit{
        print("❌ Deinit KeyboardHandler")
        
    }
    
    
    
    
}


