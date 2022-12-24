//
//  HomeViewModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    init() {
        // 처음 Home 진입 시 설정
        // 배경음 설정이 on이고 기존에 노래가 재생되고 있지 않았다면 배경음 재생
        MySoundSetting.BGM.updateSoundState(soundType: .BGM)
        
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel 소멸")
    }
    
    func randomRollingPaper() -> RollingPaper? {
        var item = MyUserDefaults.rollingPaperList?.filter { $0.isUnlocked == false }.randomElement()
        item?.isUnlocked = true
        
        MyUserDefaults.rollingPaperList = MyUserDefaults.rollingPaperList?.map { $0.id == item?.id ? item : $0 } as? [RollingPaper]
        
        print("랜덤 아이템:", item ?? "item is nil")
        
        return item
    }
}
