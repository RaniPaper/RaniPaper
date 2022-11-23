//
//  LockView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI
import Combine

struct LockView: View {
    @Binding var lockState:LockState
    @ObservedObject var viewModel = LockViewModel()
    

    var body: some View {
        ZStack(){
            Color.gray
            VStack{
                Text("코드를 입력해주세요")
                    .foregroundColor(.white)
                    .font(.title3)
                Image(systemName: "lock.circle")
                    .font(.custom("lock", size: 50))
                     .padding(30)
                
                VStack{
                    SecureField("", text: $viewModel.text)
                        .foregroundColor(.white)
                        .font(.callout)
                        .onChange(of: viewModel.text) { newValue in
                            if(newValue == "1234"){
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                    withAnimation {
                                        lockState = .vlichan
                                    }
                                }
                            }
                        }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white)
                      
                }.frame(width:ScreenSize.width/3)
                    .padding(.horizontal,30)
                    .offset(y: viewModel.keyboardHeight == .zero ? 0 : -viewModel.keyboardHeight)
                    
                
                
                    
                
            }//.padding(50)
               
        }
        .ignoresSafeArea()
            
            
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView(lockState: .constant(.locked))
    }
}
