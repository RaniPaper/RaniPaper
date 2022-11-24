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
            VStack{
                Text("당신은 누구??")
                    .font(Font.jua(size: 30))
                
                HStack{
                    Button {
                        print("hello")
                    } label: {
                        CircleImage(source: "vlic1",color:Color.green1)
                        
                    }
                    
                    Button {
                        print("hello")
                    } label: {
                        CircleImage(source: "vlic1",color:Color.lightBrown)
                        
                    }
                }
                
            }
        }
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView()
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
