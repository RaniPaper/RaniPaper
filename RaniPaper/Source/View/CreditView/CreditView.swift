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
                ScrollView{
                    VStack(spacing:5){
                        Text("팀장").font(.efDiary(20)).foregroundColor(.memoPrimary).frame(maxWidth: .infinity)
                        HStack(spacing:5){
                            Image("creditClover")
                                .resizable()
                                .scaledToFit()
                                .frame(width:13,height: 13)
                            Text("테아")
                                .font(.efDiary(13)).foregroundColor(.memoPrimary)
                        }
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                        
                    }.padding(.top)
                    
                    CreditGridView(teamName: "기획 / 연출", teamMembers: ["냄냄","도네최고아이돌","아코","우파루파맨","테아","청달이"])
                    
                    CreditGridView(teamName: "개발", teamMembers: ["iOS Hamp","케이","굵은소금"])
                    
                    CreditGridView(teamName: "UI / 디자인", teamMembers: ["계란밥","doki","밤바다소다","유문암"])
                    
                    CreditGridView(teamName: "일러스트", teamMembers: ["계란밥","레모네","와랑","테아","혓바늘"])
                    
                    CreditGridView(teamName: "에니메이션", teamMembers: ["레모네"])
                    
                    CreditGridView(teamName: "효과음 / 배경음", teamMembers: ["히사이시죠이시죠"])
                    
                    
                    
                    
                   
                    
                    
                    
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                    .background {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.memoBg)
                                
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.memoPrimary, lineWidth:2)
                                .zIndex(2.0)
                            
                        }
                        
                        
                            
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                
                
                
                
                    
                
                
                
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


struct CreditGridView: View {
    
    var teamName:String
    var teamMembers:[String]
    
    
    var body: some View {
        let size:CGFloat = 13
        VStack(spacing:5){
            Text(teamName).font(.efDiary(20)).foregroundColor(.memoPrimary).frame(maxWidth: .infinity)
            HStack(spacing:0){
                
                ForEach(teamMembers,id: \.self){ (member:String) in
                    Image("infoLeaf")
                        .resizable()
                        .scaledToFit()
                        .frame(width:size,height: size)
                    Text(member)
                        .font(.efDiary(size)).foregroundColor(.memoPrimary)
                }
                
            }
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(Color.memoPrimary)
                .frame(height: 1).padding(.horizontal,15)
                .padding(.top,3)
            
        }
    }
}
