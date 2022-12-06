//
//  EditTaskView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI
import AlertToast

struct EditTaskView: View {
    @StateObject var viewModel = EditTaskViewModel()
    @Binding var showEdit: Bool
    @State private var showToast = false
    var existTask: TaskModel? // 기존의 task
    
    //keyboardHandler = KeyboardHander()
    let colors:[String] =  ["woowakgood","ine","jingburger","lilpa","jururu","gosegu","viichan","panzee"]
    let tickets:[String] = ["우왁굳","아이네","징버거","릴파","주르르","고세구","비챤","현생"]
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @Namespace var animation
    @Namespace var bottom //keyboard 올라올 때 사용할 bottom 버튼 ID
    
    var body: some View {
        
        VStack(spacing: 0){
            // - MARK: 타이틀 및 뒤로가기
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment:.leading){
                    Button {
                        UIApplication.shared.endEditing()
                        showEdit = false
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }.padding()
                    
                }
            
            
            
            GeometryReader { proxy in
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack{
                            // - MARK: Sample Card Colors
                            VStack(alignment:.leading,spacing: 12) {
                                Text("Color")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                HStack(spacing: 15){
                                    ForEach(colors,id:\.self){ color in
                                        Circle()
                                            .fill(Color(color))
                                            .frame(width: 25, height: 25)
                                            .background {
                                                if viewModel.taskColor == color {
                                                    Circle()
                                                        .strokeBorder(.gray)
                                                        .padding(-3)
                                                }
                                            }
                                            .contentShape(Circle()) //탭 영역을 넓히기위해
                                            .onTapGesture {
                                                //선택 색 변경
                                                UIApplication.shared.endEditing()
                                                viewModel.taskColor = color
                                            }
                                        
                                    }
                                }.padding(.top,10)
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.top,30)
                            
                            Divider()
                                .padding(.vertical,10)
                            
                            // - MARK: Deadline
                            VStack(alignment: .leading,spacing: 12) {
                                Text("Task Deadline")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    DatePicker.init("", selection: $viewModel.taskDeadLine,
                                                    in:Date.now...Date.distantFuture,
                                                    displayedComponents: [.date, .hourAndMinute]
                                    )
                                    .datePickerStyle(.automatic)
                                    .labelsHidden()
                                    
                                    Spacer()
                                    
                                    Image(systemName: "calendar").foregroundColor(.black)
                                }
                            }
                                
                            Divider()
                                .padding(.vertical,10)
                            
                            // - MARK: Title
                            VStack(alignment: .leading,spacing: 12) {
                                Text("Task Title")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.vertical,10)
                                TextField("할 일",text: $viewModel.taskTitle)
                                    .frame(maxWidth: .infinity)
                                Divider()
                            }
                            
                            // MARK:  Ticket
                            VStack(alignment: .leading,spacing: 12) {
                                Text("Ticket")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.vertical,10)
                                
                                LazyVGrid(columns: columns) {
                                    ForEach(tickets,id:\.self){ ticket in
                                        Text(ticket)
                                            .font(.callout)
                                            .padding(.vertical,8)
                                            .frame(maxWidth:.infinity)
                                            .foregroundColor(viewModel.taskTicket == ticket ? .white : .black)
                                            .background{
                                                if viewModel.taskTicket == ticket{
                                                    Capsule()
                                                        .fill(.black)
                                                        .matchedGeometryEffect(id: "Ticket", in: animation)
                                                }
                                                else{
                                                    Capsule()
                                                        .strokeBorder(.black)
                                                }
                                            }
                                            .contentShape(Capsule())
                                            .onTapGesture {
                                                withAnimation{
                                                    UIApplication.shared.endEditing()
                                                    viewModel.taskTicket = ticket
                                                    
                                                }
                                            }
                                    }
                                }
                                
                                Divider()
                            }
                            
                            Spacer()
                            Button {
                                if viewModel.update() {
                                    UIApplication.shared.endEditing()
                                    showEdit = false
                                } else {
                                    showToast = true
                                }
                                
                            } label: {
                                Text("스케쥴 저장하기")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,12)
                                    .foregroundColor(.white)
                                    .background {
                                        Capsule()
                                            .fill(.black)
                                    }
                            }
                            //    .padding(.bottom,10)
                            .disabled(viewModel.taskTitle == "")
                            .opacity(viewModel.taskTitle == "" ? 0.6 : 1)
                            .id(bottom)
                            
                        }
                        .frame(minHeight:proxy.size.height)
                        // ScrollView안의 Vstack에서 Spacer를 사용하기위해
                        .padding(.horizontal)
                        
                        .onChange(of: viewModel.keyboardHeight, perform: { v in
                            if(v>0)
                            {
                                //키보드가 나올 때 바텀 버튼으로 스크롤, top 까지
                                withAnimation {
                                    scrollProxy.scrollTo(bottom, anchor: .top)
                                }
                            }
                            
                        })
                    }
                    
                    .frame(width:proxy.size.width)
                    
                }
            }
            
            
        }
        .onAppear {
            print("EditTaskview - onAppear")
            // 기존 task가 있으면 뷰모델에 데이터 전달
            guard let existTask else { return }
            print("기존 task를 불러옵니다:", existTask)
            viewModel.taskId = existTask.id
            viewModel.taskTitle = existTask.title
            viewModel.taskColor = existTask.color
            viewModel.taskDeadLine = existTask.deadLine
            viewModel.taskTicket = existTask.ticket
        }
        .onDisappear {
            print("EditTaskview - onDisAppear")
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "이미 있는 제목이에요", subTitle: "다른 버그일수도?")
        }
   
        
        
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEdit: .constant(false))
    }
}
