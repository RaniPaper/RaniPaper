//
//  MemoEditView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

struct EditMemoView: View {
    
    @Binding var showEditView:Bool
    @ObservedObject var viewModel:EditMemoViewModel = EditMemoViewModel()
    
    var body: some View {
        let inputColor:Color = Color.init(hexcode: "FFFDEB")
        ZStack {

            VStack(){
                // - MARK: 타이틀 및 뒤로가기
                Text("Edit Task")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment:.leading){
                        Button {
                            UIApplication.shared.endEditing()
                            showEditView = false
                        }label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .foregroundColor(.black)
                        }.padding()
                        
                    }
                
                // MARK: 날짜,새싹,구분선
                VStack(spacing:0){
                    HStack{
                        Text(Date.dateformat.string(from: viewModel.nowDate))
                            .font(.kotra(25))
                            .foregroundColor(.memoPrimary)
                        Spacer()
                        Image("memoSprout").offset(y:3)
                    }
                    .padding(.horizontal)
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth: .infinity,maxHeight: 10)
                }
                
                
                TextField("", text: $viewModel.title)
                    .lineLimit(1)
                    .font(.beomsuk(30))
                    .textFieldStyle(.roundedBorder)
                    .border(Color.memoPrimary,width:3)
                    .colorMultiply(inputColor) //배경색
                    .padding(.top,10)
                    .padding(.horizontal,5)
                   
                VStack {
                    TextEditor(text: $viewModel.content)
                        .font(.beomsuk(30))
                        .colorMultiply(inputColor)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,5) //글자 들여쓰기를 위한 패딩
                }
                .background(inputColor)
                .border(Color.memoPrimary,width:3)
                .padding(.top,5)
                .padding(.horizontal,5)
                .padding(.bottom,30)
                .overlay {
                    VStack{
                        Button {
                            UIApplication.shared.endEditing()
                            
                        } label: {
                            Image("memoSave")
                        }
                        
                        .padding(.bottom,5)
                        .padding(.trailing,5)
                        

                    }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
                }
                    
                    
                   
                    
                
                
                
                
               
            }
        }
        //.edgesIgnoringSafeArea(.vertical)
        .background(Color.memoBg)
        
    }
}

struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(showEditView: .constant(false))
    }
}
