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
    var title:String
    var deadLine: Date = Date()
    var color:String = "Tree"
    var ticket:String
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
        TaskModel(title: "Talk1_1 ",ticket: "우왁굳"),
        TaskModel(title: "Talk1_2 ",ticket: "아이네"),
        TaskModel(title: "Talk1_3 ",ticket: "라라"),
    ], taskDate: getSampleDate(offset: 1) ),
    TaskMetaData(task: [
        TaskModel(title: "Talk2_1 ",ticket: "우왁굳"),
        TaskModel(title: "Talk2_2 ",ticket: "우왁굳"),
        TaskModel(title: "Talk2_3 ",ticket: "우왁굳"),
    ], taskDate: getSampleDate(offset: -3) ),
    
    TaskMetaData(task: [
        TaskModel(title: "Talk3_1 ",ticket: "우왁굳"),
        TaskModel(title: "Talk3_2 ",ticket: "우왁굳"),
        TaskModel(title: "Talk3_3 ",ticket: "우왁굳"),
    ], taskDate: getSampleDate(offset: -8) )
]


