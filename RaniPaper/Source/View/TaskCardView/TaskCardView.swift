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
    @State var showDeleteAlert: Bool = false
    @Binding var showDeleteErrorAlert: Bool
    let task:TaskModel
    
    init(viewModel: CalendarViewModel, task: TaskModel, showDeleteErrorAlert: Binding<Bool>) {
        self.viewModel = viewModel
        self.task = task
        self._showDeleteErrorAlert = showDeleteErrorAlert
    }
    
    var body: some View {
        Button {
            showEdit = true
        } label: {
            VStack(alignment: .leading,spacing: 10) {
                HStack{
                    Text(task.ticket)
                        .font(.callout)
                        .foregroundColor(.black)
                        .padding(.vertical,5)
                        .padding(.horizontal)
                        .background{
                            Capsule()
                                .fill(.gray.opacity(0.3))
                        }
                    Spacer()
                    
        
                        Button {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        .alert("정말로 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                            Button("삭제", role: .destructive) {
                                let isSuccess = viewModel.deleteTask(id: task.id)
                                if !isSuccess { showDeleteErrorAlert = true }
                                viewModel.fetchTasks()
                            }
                        } message: {
                            Text("동작을 되돌릴 수 없습니다.")
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
                                .foregroundColor(.black)
                        } icon: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                        }
                        .font(.caption)
                        
                        Label{
                            Text(task.deadLine.formatted(date: .omitted, time: .shortened))
                                .foregroundColor(.black)
                        } icon: {
                            Image(systemName: "clock")
                                .foregroundColor(.black)
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
        
        
        .fullScreenCover(isPresented: $showEdit) {
            EditTaskView(showEdit: $showEdit, existTask: task).onDisappear {
                viewModel.fetchTasks()
            }
        }
        
        
        
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(viewModel: CalendarViewModel(), task: TaskModel(title: "123",color:"ine",ticket: "우왁굳"), showDeleteErrorAlert: .constant(false))
    }
}
