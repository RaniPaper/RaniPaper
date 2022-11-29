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
    let colors:[String ] =  ["Yel","Skyblue","Tree","Ren","Mint","Grape"]
    var body: some View {
        
        
     
                VStack(spacing: 12){
                    // - MARK: 타이틀 및 뒤로가기
                    Text("Edit Task")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .overlay(alignment:.leading) {
                            Button {
                                showEdit = false
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }

                        }
                    
                    // - MARK: Sample Card Colors
                    VStack(alignment:.leading,spacing: 12) {
                        Text("Task Color")
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
                            print("Hello")
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
                        TextField("TASK",text: $viewModel.taskTitle)
                            .frame(maxWidth: .infinity)
                        Divider()
                    }
                    
                    
                    
                    Button {
                        print("Hello")
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

                    
                }
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.horizontal)
               
            .padding(.bottom,viewModel.keyboardHeight)
         
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEdit: .constant(false))
    }
}
