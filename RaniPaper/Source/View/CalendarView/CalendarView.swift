//
//  CalendarView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI
import PopupView
struct CalendarView: View {
    
    @StateObject var viewModel = CalendarViewModel()
    var body: some View {
        
        ZStack(alignment:.bottom) {
            ScrollView(.vertical,showsIndicators: false)
            {
                VStack(spacing: 20) {
                    
                    CustomDatePicker(viewModel: viewModel)
                    
                    HStack {
                        Text("Tasks").font(.title2.bold())
                        Spacer()
                    }.padding(.horizontal, 15)
                    
                    TasksListView().padding(15)
                    
                    
                }
                .padding(.vertical)
            }
            
            Spacer(minLength: 20)
            HStack {
                           
                           Spacer()
                           
                           Button(action: {
                               //Place your action here
                               viewModel.showEdit = true
                           }) {
                               Image("Floating")
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(width: 70, height: 70)
                                   .padding(.bottom,10)
                                   .padding(.trailing,10)
                           }
                           
                           
            }
            //HStack
            
        }
        .fullScreenCover(isPresented: $viewModel.showEdit) {

            EditTaskView(showEdit: $viewModel.showEdit)
                .onDisappear {
                    viewModel.fetchTasks()
                    
                }
        }
        
        
       
    }
    
    func TasksListView() -> some View {
        VStack(spacing: 15) {
            if let tasks = viewModel.tasks.filter({ $0.deadLine.isSameDay(with: viewModel.currentDate)}) {
                if !tasks.isEmpty {
                    ForEach(tasks) { task in
                        TaskCardView(viewModel: viewModel, task: task)
                    }
                } else {
                    Text("오늘은 할 일이 없어요").foregroundColor(.gray)
                }
                
            } else {
                Text("오늘은 할 일이 없어요")
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
