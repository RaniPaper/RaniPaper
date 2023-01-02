//
//  MainViewModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import Foundation
import Combine
import SwiftUI
import AVKit

final class MainViewModel : ObservableObject {
    @Published var isLoading: Bool
    @Published var selection: ViewSelection
    let audioSession = AVAudioSession.sharedInstance()

    init(){
        self.isLoading = true
        self.selection = .home
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
        } catch {
           print("🔥 오디오 세션 설정에 실패했습니다")
        }
        
        do {
            try audioSession.setActive(true)
        } catch {
            print("🔥 오디오 세션 활성에 실패했습니다")
        }
        
        print("✅ MainViewModel 생성")
    }
    
    deinit{
        print("❌ MainViewModel 소멸")
        
        do {
            try audioSession.setActive(false)
        } catch {
            print("🔥 오디오 세션 비활성에 실패했습니다")
        }
    }
    
}
