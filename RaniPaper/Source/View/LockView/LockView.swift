//
//  LockView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI
import Combine

struct LockView: View {
    @Binding var userType: UserType
    @Binding var showLockView: Bool
    @StateObject var viewModel = LockViewModel()
    let gangfont:Font = Font.gangwonBold(20)
    fileprivate let bgGradient = Color(hexcode: "e7f4ea")
    fileprivate let textFieldColor = Color(hexcode: "69ad72")
    fileprivate let textColor = Color(hexcode: "3e6c45")
    let secretCode:String = "1234"
    
    
    var body: some View {
        VStack(spacing:10){
            HStack(spacing:5){
                Text("안녕하세요").font(gangfont)
                Text("비챤님").font(gangfont).foregroundColor(textColor)
            }
            HStack(spacing:0){
                Text("비밀번호").font(gangfont).foregroundColor(textColor)
                Text("를 입력해주세요").font(gangfont)
                Text("💚").font(.caption)
            }.padding(.bottom,20)
            
            if(viewModel.error)
            {
                Text("잘못된 비밀번호입니다.").font(.oneMobileRegular(15))
                    .foregroundColor(.red)
            }
            
            
            HStack{
                TextField("", text: $viewModel.text)
                    .font(.oneMobileRegular(20))
                    .foregroundColor(.white)
                    .autocorrectionDisabled()
                    .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
            }
            .background(
                RoundedRectangle(cornerRadius: 20).foregroundColor(textFieldColor)
                    .shadow(radius: 5)
            )
            .padding(.bottom,10)
            
           
            
            
            
            Button(action: {
                if(viewModel.text == secretCode)
                {
                    showLockView = false
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        withAnimation {
                            userType = .viichan
                        }
                    }
                }
                else
                {
                    viewModel.error = true
                }
            }, label: {
                Text("확인").font(Font.kotra(20))
                    .foregroundColor(textColor)
                    .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
            })
            .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 3)
            )
            
            
            
        }
        .padding(50)
        .background(
            bgGradient
                .cornerRadius(10)
                .shadow(radius: 3)
        )
        .frame(maxWidth: 300,maxHeight: 300)
        .offset(y:-ScreenSize.height/8)
       
        
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView(userType: .constant(.none),showLockView: .constant(false))
    }
}
