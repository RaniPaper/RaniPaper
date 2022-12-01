//
//  CreditView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
//  Credit View For Test

import SwiftUI

struct CreditView: View {
    var body: some View {
        ZStack{
            VStack{
                Text("라니 페이퍼")
                    .bold()
                    .font(.efDiary(30))
                    .padding(40)
                VStack(){
                    Group{
                        Text("팀장: ㅇ 테아")
                            .padding(20)
                        Text("기획: 모시깽1, 모시깽2")
                            .padding(20)
                        Text("개발: 모시깽3, 모시깽4")
                            .padding(20)
                        Text("사운드: 모시깽5")
                            .padding(20)
                        Text("연출: 모시깽6, 모시깽7, 모시깽8")
                            .padding(20)
                        Text("일러스트: 모시깽9, 모시깽10, 모시깽11")
                            .padding(20)
                        Text("UI: 모시깽12, 모시깽13, 모시깽14")
                            .padding(20)
                    }
                    
                    Image("Launch")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                }
                .frame(width: ScreenSize.width)
            }
            .frame(height: ScreenSize.height)
        }
        .ignoresSafeArea()
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
