//
//  RollingPaperModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/14.
//

import Foundation

fileprivate enum BackgroundImageFormat: String, CaseIterable {
    case heart = "paper_heart"
    case butterfly = "paper_butterfly"
    case rectangle = "paper_rectangle"
    case flower = "paper_flower"
}

struct RollingPaper: Identifiable, Codable {
    var id = UUID().uuidString
    var contentImage: String
    var backgroundImage: String
    var firstChecked: Bool = false
}

let rollingPaperList = [
    RollingPaper(contentImage: "rolling_paper_1", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_2", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_3", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_4", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_5", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_6", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue),
    RollingPaper(contentImage: "rolling_paper_7", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue)
]
