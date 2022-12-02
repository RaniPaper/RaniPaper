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
        print("✅ HomeViewModel 생성")
    }
    
    deinit {
        print("❌ HomeViewModel 소멸")
    }
}
