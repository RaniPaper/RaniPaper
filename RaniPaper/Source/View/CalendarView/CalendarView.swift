//
//  CalendarView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI
import PopupView
import AlertToast

struct CalendarView: View {
    @StateObject var viewModel = CalendarViewModel()
    @State var showDeleteErrorAlert: Bool = false
    
    var body: some View {
        
        ZStack(alignment:.bottom) {
            ScrollView(.vertical,showsIndicators: false)
            {
                VStack(spacing: 20) {
                    
                    CustomDatePicker(viewModel: viewModel)
                    
                    HStack {
                        Image("diaryNote")
                        Text("오늘의 할 일").font(.efDiary(20))
                        Spacer()
                    }.padding(.horizontal, 15)
                    
                    TasksListView().padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
                    Spacer(minLength: 40)
                    
                }
                .padding(.vertical)
                .toast(isPresenting: $showDeleteErrorAlert) {
                    AlertToast(displayMode: .hud, type: .error(.red), title: "삭제에 실패했어요!", subTitle: "헤이 디벨로퍼?")
                }
                
            }
            
           
            HStack {
                           
                           Spacer()
                           
                           Button(action: {
                               //Place your action here
                               viewModel.showEdit = true
                           }) {
                               Image("diaryWrite")
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(width: 50, height: 50)
                                   .padding(.bottom,20)
                                   .padding(.trailing,20)
                           }
                           
                           
            }
            //HStack
            
            OnBoardView(currentView: .diary)
            
        }
        .fullScreenCover(isPresented: $viewModel.showEdit) {

            EditTaskView(showEdit: $viewModel.showEdit)
                .onDisappear {
                    viewModel.fetchTasks()
                    
                }
        }
        .padding(.vertical,1)
        
       
    }
    
    func TasksListView() -> some View {
        VStack(spacing: 15) {
            if let tasks = viewModel.tasks.filter({ $0.deadLine.isSameDay(with: viewModel.currentDate)}) {
                if !tasks.isEmpty {
                    ForEach(tasks) { task in
                        TaskCardView(viewModel: viewModel, task: task,showDeleteErrorAlert: $showDeleteErrorAlert)
                    }
                } else {
                    VStack(spacing: 0){
                        Image("noTask\(viewModel.randomInt)")
                        Text("\(viewModel.noTaskMessages[viewModel.randomInt])").font(.efDiary(20)).foregroundColor(Color(hexcode: "909090"))
                    }
                }
                
            } else {
                VStack(spacing: 0){
                    Image("noTask\(viewModel.randomInt)")
                    Text("\(viewModel.noTaskMessages[viewModel.randomInt])").font(.efDiary(20)).foregroundColor(Color(hexcode: "909090"))
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
