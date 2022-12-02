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
        ZStack {
            Color.memoBg
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
                
                
               
            }
        }.edgesIgnoringSafeArea(.vertical)
        
    }
}

struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(showEditView: .constant(false))
    }
}
