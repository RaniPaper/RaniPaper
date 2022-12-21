//
//  InfoView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
// Info View For Test


import SwiftUI

struct InfoView: View {
    
    let height = ScreenSize.height/6
    
    var body: some View {
        ZStack{
            Color(hexcode: "B2BFAC")
            // MARK: Header
            VStack(spacing: 0) {
                VStack(spacing: 0){
                    Spacer()
                    Text("앱 정보")
                        .font(.efDiary(35))
                        .foregroundColor(.memoPrimary)
                    Text("App Information")
                        .font(.efDiary(13))
                        .foregroundColor(.memoPrimary)
                    
                    Spacer()
                    Rectangle().frame(maxHeight: 2).foregroundColor(.memoPrimary)
                }
                .padding(.top,20)
                .frame(maxWidth: .infinity,maxHeight: height)
                .background {
                    Color.memoBg
            }
                Spacer()
                
                VStack{
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                    
                
                
                
                VStack(spacing:20){
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:.infinity,maxHeight: 1)
                    Rectangle()
                        .fill(Color(hexcode: "F4D4B6"))
                        .frame(maxWidth:ScreenSize.width/3,maxHeight: 2)
                   
                    
                        
                    
                    Spacer()
                }.frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6,alignment: .top)
                    .background(Color.memoBg)
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
