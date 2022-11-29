//
//  TaskModel.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI


//Task Model
struct TaskModel: Identifiable{
    var id = UUID().uuidString
    var title:String
    var deadLine: Date = Date()
    var isComplete:Bool = false
    var color:String = "Tree"
}


// Total Task Meta View
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task:[TaskModel]
    var taskDate: Date
}

// sample Date for Testing...

func getSampleDate(offset: Int)->Date {
    
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}


var tasks: [TaskMetaData] = [
    
    TaskMetaData(task: [
        TaskModel(title: "Talk1_1 "),
        TaskModel(title: "Talk1_2 "),
        TaskModel(title: "Talk1_3 "),
    ], taskDate: getSampleDate(offset: 1) ),
    TaskMetaData(task: [
        TaskModel(title: "Talk2_1 "),
        TaskModel(title: "Talk2_2 "),
        TaskModel(title: "Talk2_3 "),
    ], taskDate: getSampleDate(offset: -3) ),
    
    TaskMetaData(task: [
        TaskModel(title: "Talk3_1 "),
        TaskModel(title: "Talk3_2 "),
        TaskModel(title: "Talk3_3 "),
    ], taskDate: getSampleDate(offset: -8) )
]


