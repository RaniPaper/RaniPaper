//
//  HomeViewModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import Foundation

class HomeViewModel: ObservableObject {
    var rollingPapers: [String] = ["rolling_paper_temp_1", "rolling_paper_temp_2", "rolling_paper_temp_3"]
    init() {
        // 처음 Home 진입 시 설정
        // 배경음 설정이 on이고 기존에 노래가 재생되고 있지 않았다면 배경음 재생
        MySoundSetting.BGM.updateSoundState(soundType: .BGM)
        
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel 소멸")
    }
}
