//
//  HomeViewModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import Foundation

class HomeViewModel: ObservableObject {
    private var isBGMOn = UserDefaults.standard.bool(forKey: "배경음")
 
    init() {
        // 처음 Home 진입 시 설정
        // 배경음 설정이 on이고 기존에 노래가 재생되고 있지 않았다면 배경음 재생
        if isBGMOn{
            if !MySoundSetting.BGM.isPlaying() {
                MySoundSetting.BGM.play()
            }
        }
        
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel 소멸")
    }
}
