//
//  TaskCardView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/29.
//

import SwiftUI

struct TaskCardView: View {
    
    let task:TaskModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            HStack{
                Text("GGGG")
                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.gray.opacity(0.3))
                    }
                Spacer()
                
                if !task.isComplete{
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }

                }
            }
            
            
            Text(task.title)
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical,10)
            
            HStack(alignment: .bottom,spacing: 0) {
                VStack(alignment: .leading,spacing: 10) {
                    Label{
                        Text(task.deadLine.formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label{
                        Text(task.deadLine.formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 12,style: .continuous)
                .fill(Color(task.color))
        }
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(task: TaskModel(title: "123"))
    }
}
