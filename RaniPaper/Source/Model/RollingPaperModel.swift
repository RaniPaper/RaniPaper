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
    var position: CGSize = CGSize()
}

let rollingPaperList: [RollingPaper] = (1...111).map { RollingPaper(contentImage: "rolling_paper_\($0)", backgroundImage: BackgroundImageFormat.allCases.randomElement()!.rawValue) }
