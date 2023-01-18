//
//  TaskModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI


//Task Model
struct TaskModel: Identifiable,Codable{
    var id = UUID().uuidString
    var title: String
    var deadLine: Date 
    var color: String
    var ticket: String
    var timeInterval:TimeIntervals
}





