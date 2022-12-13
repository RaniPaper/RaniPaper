//
//  LaunchVIew.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI

struct LaunchView: View {
    
    
    @EnvironmentObject var userState: UserState
    let titleViichan =  "비챤님의 일상에 자그마한 행복을"
    let titleFan =  "당신의 일상 곁에 언제나 함께하는"
    var body: some View {
        ZStack(){
            
            LinearGradient(colors: [.white,userState.userType == .viichan ? Color(hexcode: "e8f4ea") : Color(hexcode: "fff1d4")], startPoint: .top, endPoint: .bottom)
            
                   VStack(spacing:0){
                       Text("라니페이퍼").font(.nanum(40))
                           .padding(.bottom,5)
                       Image("Launch")
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .padding(.horizontal,50)
                       Text(userState.userType == .viichan ? titleViichan : titleFan).font(.chosun(20)).padding(.horizontal)
                       
                   }

               }.ignoresSafeArea()

    }
}

struct LaunchVIew_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(UserState())
    }
}
