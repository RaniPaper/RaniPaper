//
//  HomeViewModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var backgroundTime: BackgroundTime = .moring
    
    init() {
        // 처음 Home 진입 시 설정
        // 배경음 설정이 on이고 기존에 노래가 재생되고 있지 않았다면 배경음 재생
        MySoundSetting.BGM.updateSoundState(soundType: .BGM)
        
        backgroundTime = getCurrentTime(input: Date())
        
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel 소멸")
    }
    
    func randomRollingPaper() -> RollingPaper? {
        var item = MyUserDefaults.rollingPaperList?.filter { $0.firstChecked == false }.randomElement()
        item?.firstChecked = true
        
        MyUserDefaults.rollingPaperList = MyUserDefaults.rollingPaperList?.map { $0.id == item?.id ? item : $0 } as? [RollingPaper]
        
        print("랜덤 아이템:", item ?? "item is nil")
        
        return item
    }
}

extension HomeViewModel{
    enum BackgroundTime: String, CaseIterable{
        case moring = "morning"
        case noon = "noon"
        case sunset = "sunset"
        case night = "night"
        
        func getTimeInterval() -> ClosedRange<Int>{
            switch self{
            case .moring:
                return 7...10
            case .noon:
                return 11...15
            case .sunset:
                return 16...19
            case .night:
                return 0...7
            }
        }
    }
    
    func getCurrentTime(input: Date) -> BackgroundTime{
        let dateFormatter = DateFormatter()
        var currentHour = 0
        dateFormatter.dateFormat = "HH"
        currentHour =  Int(dateFormatter.string(from: input)) ?? 0
        
        for time in BackgroundTime.allCases{
            if time.getTimeInterval().contains(currentHour){
                return time
            }
        }
        return .night
    }
}
