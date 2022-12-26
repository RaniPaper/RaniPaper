//
//  MemoModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/01.
//

import Foundation

struct MemoModel: Identifiable, Codable {
    var id = UUID().uuidString
    var date: Date = Date()
    var title:String
    var content: String
    var stamp:Int
}
