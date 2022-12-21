//
//  InfoView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
// Info View For Test


import SwiftUI

struct CreditView: View {
    
    let height = ScreenSize.height/6
    
    
    var body: some View {
        ZStack{
            Color(hexcode: "B2BFAC")
            
            VStack(spacing: 0) {
                // MARK: Header
                VStack(spacing: 0){
                    Spacer()
                    Text("크레딧")
                        .font(.efDiary(35))
                        .foregroundColor(.memoPrimary)
                    Text("credits")
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
                
                
                    
                
                
                
                // MARK: Footer
                VStack(spacing:20){
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:.infinity,maxHeight: 1)
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:ScreenSize.width/3,maxHeight: 2)
                   
                    
                        
                    
                    Spacer()
                }.frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6,alignment: .top)
                    .background(Color.memoBg)
            }
           
            
            
        }
        .ignoresSafeArea()
    }
}




struct Credit_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}

struct CreditDetailView: View {
    
    var content:String
    
    var body: some View {
        HStack{
            Image("infoLeaf")
                .resizable()
                .scaledToFit()
                .frame(width:20,height: 20)
            Text(content)
                .foregroundColor(.memoPrimary)
                .font(.efDiary(15))
            
        }.frame(maxWidth: .infinity).padding(.horizontal,15)
    }
}

