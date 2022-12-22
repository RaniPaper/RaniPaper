//
//  BackgroundViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/22.
//

import Foundation

class BackgroundViewModel: ObservableObject {
    @Published var backgroundTime: BackgroundTime = .moring
    
    init() {
        backgroundTime = getCurrentTime(input: Date())
        
        print("✅ BackgroundViewModel 생성")
    }
    
    deinit {
        print("❌ BackgroundViewModel 소멸")
    }
}

extension BackgroundViewModel{
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
                return 0...6
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
