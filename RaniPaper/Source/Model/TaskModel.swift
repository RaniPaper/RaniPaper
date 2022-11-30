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
    var color:String
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
        TaskModel(title: "Talk1_1 ",color: "ine",ticket: "우왁굳"),
        TaskModel(title: "Talk1_2 ",color: "jingburger",ticket: "아이네"),
        TaskModel(title: "Talk1_3 ",color: "lilpa",ticket: "릴파"),
        TaskModel(title: "Talk1_3 ",color: "jururu",ticket: "주르르"),
        TaskModel(title: "Talk1_3 ",color: "gosegu",ticket: "고세구"),
        TaskModel(title: "Talk1_3 ",color: "viichan",ticket: "비챤"),
    ], taskDate: getSampleDate(offset: 1) ),
    TaskMetaData(task: [
        TaskModel(title: "Talk1_1 ",color: "ine",ticket: "우왁굳"),
        TaskModel(title: "Talk1_2 ",color: "jingburger",ticket: "아이네"),
        TaskModel(title: "Talk1_3 ",color: "lilpa",ticket: "릴파"),
        TaskModel(title: "Talk1_3 ",color: "jururu",ticket: "주르르"),
        TaskModel(title: "Talk1_3 ",color: "gosegu",ticket: "고세구"),
        TaskModel(title: "Talk1_3 ",color: "viichan",ticket: "비챤"),
    ], taskDate: getSampleDate(offset: -3) ),
    
    TaskMetaData(task: [
        TaskModel(title: "Talk1_1 ",color: "ine",ticket: "우왁굳"),
        TaskModel(title: "Talk1_2 ",color: "jingburger",ticket: "아이네"),
        TaskModel(title: "Talk1_3 ",color: "lilpa",ticket: "릴파"),
        TaskModel(title: "Talk1_3 ",color: "jururu",ticket: "주르르"),
        TaskModel(title: "Talk1_3 ",color: "gosegu",ticket: "고세구"),
        TaskModel(title: "Talk1_3 ",color: "viichan",ticket: "비챤"),
    ], taskDate: getSampleDate(offset: -8) )
]


