//
//  EditTaskView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

struct EditTaskView: View {
    
    @Binding var showEdit:Bool
    @StateObject var viewModel = EditTaskViewModel()
     //keyboardHandler = KeyboardHander()
    let colors:[String] =  ["ine","jingburger","lilpa","jururu","gosegu","viichan"]
    let tickets:[String] = ["우왁굳","아이네","징버거","릴파","주르르","고세구","비챤","현생"]
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @Namespace var animation
    
    var body: some View {
                VStack(spacing: 12){
                    // - MARK: 타이틀 및 뒤로가기
                    Text("Edit Task")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .overlay(alignment:.leading) {
                            Button {
                                UIApplication.shared.endEditing()
                                showEdit = false
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }

                        }
                    
                    // - MARK: Sample Card Colors
                    VStack(alignment:.leading,spacing: 12) {
                        Text("제목")
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
                        
                        Text(viewModel.taskDeadLine.formatted(date: .numeric, time: .shortened))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.top,8)
                        
                           
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .overlay(alignment:.bottomTrailing) {
                        Button {
                            UIApplication.shared.endEditing()
                            viewModel.showDatePicker.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                        }

                        
                    }
                    Divider()
                    
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
                                    .foregroundColor(viewModel.ticket == ticket ? .white : .black)
                                    .background{
                                        if viewModel.ticket == ticket{
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
                                            viewModel.ticket = ticket
                                            
                                        }
                                    }
                            }
                        }
                        
                        Divider()
                    }
                    
                    
                    
                    
                    
                    Button {
                        UIApplication.shared.endEditing()
                       showEdit = false
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
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.bottom,10)
                    .disabled(viewModel.taskTitle == "")
                    .opacity(viewModel.taskTitle == "" ? 0.6 : 1)

                }
                .frame(maxHeight: .infinity,alignment: .top)
                .padding()
                .padding(.bottom,viewModel.keyboardHeight)
                .overlay {
                    ZStack{
                        if viewModel.showDatePicker{
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    viewModel.showDatePicker = false
                                }
                            
                            
                            // MARK: DataPicker
                            //현재부터 미래 까지
                            //데이터 피커와 viewModel 데드라인 연결
                            VStack(spacing: 5) {
                                DatePicker.init("", selection: $viewModel.taskDeadLine,
                                                in:Date.now...Date.distantFuture)
                                .datePickerStyle(.graphical) //달력과 시간을 그래픽컬하게
                            //    .labelsHidden()
                                .background(.white,in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                            .padding()
                                Button {
                                    viewModel.showDatePicker = false
                                } label: {
                                    Text("날짜 저장하기")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                      
                                        .padding(15)
                                        .foregroundColor(.white)
                                        .background {
                                            Capsule()
                                                .fill(.blue)
                                                
                                            
                                        }
                                }
                            }
                            
                            
                          
                        }
                        
                        
                    }
                    
                    .animation(.easeInOut, value: viewModel.showDatePicker)
                }
        
        
         
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEdit: .constant(false))
    }
}
