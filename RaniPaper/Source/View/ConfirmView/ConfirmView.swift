//
//  ConfirmView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/24.
//

import SwiftUI

struct ConfirmView: View {
    @Binding var lockState:LockState
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.vertical)
            VStack(spacing:40){
                Text("당신은 누구??")
                    .font(Font.jua(size: 30))
                
                HStack(spacing:30){
                    VStack{
                        Button {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                withAnimation {
                                    lockState = .vlichan
                                }
                            }
                        } label: {
                            CircleImage(source: "vlic1",color:Color.green1)
                            
                        }
                        Text("비챤")
                            .font(Font.samanco(size: 30))
                    }
                    VStack{
                        Button {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                withAnimation {
                                    lockState = .rani
                                }
                            }
                        } label: {
                            CircleImage(source: "vlic1",color:Color.lightBrown)
                            
                        }
                        Text("이파리")
                            .font(Font.samanco(size: 30))
                    }
                   
                    
                    
                }
                
            }
        }
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(lockState: .constant(.locked))
    }
}

struct CircleImage: View {
    let source:String
    let color:Color
    
    var body: some View {
        ZStack{
            Circle().strokeBorder(color, lineWidth: 3)
            Image(source)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(Circle())
                .padding(7)
        }.frame(width:ScreenSize.width/4,height: ScreenSize.width/4).zIndex(1)
    }
}
