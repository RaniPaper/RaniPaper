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
            
            VStack(spacing: 0) {
                // MARK: Header
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
                
                
                // MARK: 내용
                VStack(spacing:0){
                    
                    VStack(){
                        InfoGrid("앱 버전", "App version")
                        InfoDetailView(content: "v 1.1.0")
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                    }
                    
                    VStack{
                        InfoGrid("팀 명", "Team Name")
                        InfoDetailView(content: "V2rite")
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                    }
                    
                    
                    VStack(spacing:5){
                        InfoGrid("지원", "Support")
                        HStack{
                            InfoDetailLinkView(url: "https://rani-paper.tistory.com",title: "홈페이지")
                               
                                
                            InfoDetailLinkView(url: "https://rani-paper.tistory.com/5",title: "이용약관")
                        }
                        
                        HStack{
                            InfoDetailLinkView(url: "https://rani-paper.tistory.com/3",title: "개인정보 처리방침")
                         
                        }
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                    }
                    
                    VStack(spacing:5){
                        InfoGrid("라이센스", "License")
                        
                            InfoDetailView(content: "무료글꼴, 얼리폰트, EF다이어리체")
                            InfoDetailView(content: "무료글꼴, 이범석, 휴먼범석체")
                            
                        
                        
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                        
                        
                        Text("Copyright 2023 V2rite All Rights Reserved").font(.efDiary(10)).foregroundColor(.memoPrimary)
                            .padding()
                        
                        
                    }
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                    .background {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.memoBg)
                                
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.memoPrimary, lineWidth:2)
                                .zIndex(2.0)
                            
                        }
                        
                        
                            
                    }.frame(maxWidth:.infinity,maxHeight: .infinity).padding(.horizontal)
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


func InfoGrid(_ title:String,_ subTitle:String) ->some View
{
    VStack(alignment: .leading){
        Text(title)
            .font(.efDiary(25))
            .foregroundColor(.memoPrimary)
            .frame(maxWidth: .infinity,alignment: .leading)
        Text(subTitle)
            .font(.efDiary(15))
            .foregroundColor(.memoPrimary)
            .frame(maxWidth: .infinity,alignment: .leading)
    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    
}


struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct InfoDetailView: View {
    
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
            
        }.frame(maxWidth: .infinity,alignment: .leading).padding(.horizontal,15)
    }
}

struct InfoDetailLinkView: View {
    
    var url:String
    var title:String
    
    var body: some View {
        HStack{
            Image("infoLeaf")
                .resizable()
                .scaledToFit()
                .frame(width:20,height: 20)
            
            NavigationLink {
                WebView(urlToLoad: url)
            } label: {
                Text(title)
                    .foregroundColor(.memoPrimary)
                    .font(.efDiary(15))
            }
    
            
        }.frame(maxWidth: .infinity,alignment: .leading).padding(.horizontal,15)
    }
}
