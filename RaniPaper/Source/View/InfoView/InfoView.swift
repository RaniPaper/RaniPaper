//
//  InfoView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
// Info View For Test

import SwiftUI

struct InfoView: View {
    @State var isOn = false
    var body: some View {
        VStack{
            Button(action:{
                isOn.toggle()
            }) {
                Text("Test Button")
            }
            if isOn{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.4)
                        .frame(width: ScreenSize.width * 0.8, height: ScreenSize.height * 0.4)
                    Text("'라니 페이퍼'입니다")
                        .font(.gangwonBold(30))
                }
                .transition(AnyTransition.scale.animation(.easeInOut))
                .onTapGesture {
                    isOn = false
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
