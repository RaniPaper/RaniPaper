//
//  TaskCardView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/29.
//

import SwiftUI

struct TaskCardView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @State var showEdit: Bool = false // viewModel.showEdit 공유하면 버그
    let task:TaskModel
    
    init(viewModel: CalendarViewModel, task: TaskModel) {
        self.viewModel = viewModel
        self.task = task
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            HStack{
                Text(task.ticket)
                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.gray.opacity(0.3))
                    }
                Spacer()
                
    
                    Button {
                        showEdit = true
                    } label: {
                        Image(systemName: "square.and.pencil")
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
        .fullScreenCover(isPresented: $showEdit) {
            EditTaskView(showEdit: $showEdit, existTask: task).onDisappear {
                viewModel.fetchTasks()
            }
        }
        
        
        
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(viewModel: CalendarViewModel(), task: TaskModel(title: "123",color:"ine",ticket: "우왁굳"))
    }
}
