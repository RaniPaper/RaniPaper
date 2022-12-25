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
    let colors:[String] =  ["woowakgood","ine","jingburger","lilpa","jururu","gosegu","viichan","twoMoreThen"]
    let tickets:[String] = ["우왁굳","아이네","징버거","릴파","주르르","고세구","비챤","2인 이상"]
    let timeIntervals:[TimeIntervals] = [.fiveMinAgo,.tenMinAgo,.thirtyMinAgo,.oneHourAgo,.twoHourAgo,.threeHourAgo]
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @Namespace var animation
    @Namespace var bottom //keyboard 올라올 때 사용할 bottom 버튼 ID
    
    var body: some View {
        
        VStack(spacing: 10){
            // - MARK: 타이틀 및 뒤로가기
          
                Image("editDiaryNote")
                    .frame(maxWidth:.infinity)
                    .overlay(alignment:.leading){
                        Button {
                            UIApplication.shared.endEditing()
                            showEdit = false
                        }label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .foregroundColor(Color(hexcode: "E5BE83"))
                        }.padding()
                        
                    }
            
            Text("일정 편집")
                .font(.efDiary(25))
                .frame(maxWidth: .infinity)
                
            
            
            
            GeometryReader { proxy in
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        let titleColor = Color(hexcode: "786E6E")
                        let divideColor = Color(hexcode: "EBDCDC")
                        let titleSize:CGFloat = 15
                        VStack{
                            // - MARK: Sample Card Colors
                            VStack(spacing: 12) {
                                Text("색")
                                    .font(Font.efDiary(titleSize))
                                    .foregroundColor(titleColor)
                                HStack(spacing:10){
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
                                Divider()
                                    .background(divideColor)
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.top,30)
                            
                           
                            
                            // - MARK: Deadline
                            VStack(spacing: 12) {
                                Text("일정")
                                    .font(Font.efDiary(titleSize))
                                    .foregroundColor(titleColor)
                                
                                
                                HStack {
                                    Spacer()
                                    Image(systemName: "calendar").foregroundColor(.brown)
                                    DatePicker.init("", selection: $viewModel.taskDeadLine,
                                                    in:Date.now...Date.distantFuture,
                                                    displayedComponents: [.date, .hourAndMinute]
                                    )
                                    .datePickerStyle(.automatic)
                                    .labelsHidden()
                                    .font(Font.efDiary())
                                    .colorMultiply(.brown) // 배경 색
                                    Spacer()
                                    
                                    
                                }
                            }
                                
                            Divider()
                                .padding(.vertical,10)
                            
                            // - MARK: Title
                            VStack(spacing: 12) {
                                Text("내용")
                                    .font(Font.efDiary(titleSize))
                                    .foregroundColor(titleColor)
                                TextField("할 일",text: $viewModel.taskTitle)
                                    .font(Font.efDiary(18))
                                    .foregroundColor(Color(hexcode: "988B8B"))
                                    .frame(maxWidth: .infinity)
                                Divider()
                            }
                            
                            
                            // MARK:  Ticket
                            VStack(spacing: 12) {
                                Text("티켓")
                                    .font(Font.efDiary(titleSize))
                                    .foregroundColor(titleColor)
                                
                                LazyVGrid(columns: columns) {
                                    let ticketColor = Color(hexcode: "988B8B")
                                    ForEach(tickets,id:\.self){ ticket in
                                        Text(ticket)
                                            .font(Font.efDiary(15))
                                            .padding(.vertical,8)
                                            .frame(maxWidth:.infinity)
                                            .foregroundColor(viewModel.taskTicket == ticket ? .white : ticketColor)
                                            .background{
                                                if viewModel.taskTicket == ticket{
                                                    Capsule()
                                                        .fill(ticketColor)
                                                        .matchedGeometryEffect(id: "Ticket", in: animation)
                                                }
                                                else{
                                                    Capsule()
                                                        .strokeBorder(ticketColor)
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
                            .id(bottom)
                            // MARK:  TimeIntervals
                            VStack(spacing: 12) {
                                Text("알림")
                                    .font(Font.efDiary(titleSize))
                                    .foregroundColor(titleColor)
                                
                                LazyVGrid(columns: columns) {
                                    let ticketColor = Color(hexcode: "988B8B")
                                    ForEach(timeIntervals,id:\.self){ timeInterval in
                                        Text(timeInterval.rawValue)
                                            .font(Font.efDiary(15))
                                            .padding(.vertical,8)
                                            .frame(maxWidth:.infinity)
                                            .foregroundColor(viewModel.timeInterval == timeInterval ? .white : ticketColor)
                                            .background{
                                                if viewModel.timeInterval == timeInterval {
                                                    Capsule()
                                                        .fill(ticketColor)
                                                        .matchedGeometryEffect(id: "timeInterval", in: animation)
                                                }
                                                else{
                                                    Capsule()
                                                        .strokeBorder(ticketColor)
                                                }
                                            }
                                            .contentShape(Capsule())
                                            .onTapGesture {
                                                withAnimation{
                                                    UIApplication.shared.endEditing()
                                                    viewModel.timeInterval = timeInterval
                                                    
                                                }
                                            }
                                    }
                                }
                                
                             

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
                                Text("일정 저장하기")
                                    .font(Font.efDiary(15))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,12)
                                    .foregroundColor(.white)
                                    .background {
                                        Capsule()
                                            .fill(viewModel.taskTitle == "" ? Color(hexcode: "988B8B") : Color(hexcode: "E5BE83") )
                                    }
                            }
                            //    .padding(.bottom,10)
                            .disabled(viewModel.taskTitle == "")
                         
                            
                            
                        }
                        .frame(minHeight:proxy.size.height)
                        // ScrollView안의 Vstack에서 Spacer를 사용하기위해
                        .padding(.horizontal)
                        
                        .onChange(of: viewModel.keyboardHeight, perform: { v in
                            if(v>0)
                            {
                                //키보드가 나올 때 바텀 버튼으로 스크롤, top 까지
                                withAnimation {
                                    scrollProxy.scrollTo(bottom, anchor: .center)
                                }
                            }
                            
                        })
                    }
                    
                    .frame(width:proxy.size.width)
                    
                }
            }
            .padding(.horizontal)
            
            
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
            viewModel.timeInterval = existTask.timeInterval
        }
        .onDisappear {
            print("EditTaskview - onDisAppear")
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "이미 있는 제목이에요.", subTitle: "다시 시도해주세요.")
        }
   
        
        
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEdit: .constant(false))
    }
}
