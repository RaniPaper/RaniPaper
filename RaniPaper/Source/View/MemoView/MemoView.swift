//
//  MemoView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/27.
//

import SwiftUI

struct MemoView: View {
    var body: some View {
        VStack{
            
            GeometryReader { proxy in
                let thin:CGFloat = 5
                let thinPadding:CGFloat = 10
                ZStack {
                    Color.memoBg
                    //왼쪽 사각형
                    VStack{
                        Rectangle()
                            .fill(Color.memoPrimary)
                            .frame(maxWidth:thin,maxHeight: proxy.size.height)
                            .padding(.leading,thinPadding)
                    }.frame(maxWidth:proxy.size.width,alignment: .leading)
                    
                    VStack(spacing: 5) {
                    
                        Text("기록")
                            .font(.efDiary(30))
                            .foregroundColor(.memoPrimary)
                        Text("(-)")
                            .font(.efDiary(20))
                            .foregroundColor(.memoPrimary)
                            .frame(maxWidth:proxy.size.width)
                            .overlay {
                                HStack{
                                    Button {
                                        
                                    } label: {
                                        HStack(spacing: 0){
                                            Text("크게보기")
                                                .font(.kotra(20))
                                                .foregroundColor(.memoPrimary)
                                            Image(systemName: "arrowtriangle.down.fill").foregroundColor(.memoPrimary)
                                        }
                                    }
                                    .overlay(alignment:.topLeading) {
                                        
                                        if true{
                                            VStack(spacing:2){
                                                
                                                Text("크게보기")
                                                    .font(.kotra(20))
                                                    .foregroundColor(.memoDropDownText)
                                                    .contentShape(Rectangle())
                                                
                                                Rectangle().frame(height: 1).padding(.horizontal,5)
                                                    .foregroundColor(.memoDropDownText)
                                                Text("작게보기")
                                                    .font(.kotra (20))
                                                    .foregroundColor(.memoDropDownText)
                                                    .contentShape(Rectangle())
                                            }
                                            .padding(.horizontal,5)
                                            .background(Color.memoDropDownBg)
                                            .offset(y:25)
                                            
                                        }
                                        
                                    }
                                    .zIndex(2.0)
                                    .offset(x:thinPadding*2)
                                
                                    
                                    Spacer()
                                    
                                    Button {
                                        
                                    } label: {
                                        Image("memoCalendar")
                                    }
                                  
                                    Button {
                                        
                                    } label: {
                                        Image("memoTrash")
                                    }.padding(.trailing,thinPadding*2)

                                }
                            }
                            .zIndex(2)
                        
                        Rectangle()
                            .fill(Color.memoPrimary)
                            .frame(maxWidth:proxy.size.width,maxHeight: 10)
                            .padding(.bottom,thinPadding).zIndex(1)
                    }
                    .frame(maxWidth:proxy.size.width,maxHeight:proxy.size.height,alignment: .bottom)
                    
                    
                    //오른쪽 사각형
                    VStack{
                        Rectangle()
                            .fill(Color.memoPrimary)
                            .frame(maxWidth:thin,maxHeight: proxy.size.height)
                            .padding(.trailing,thinPadding)
                    }.frame(maxWidth:proxy.size.width,alignment: .trailing)
                }
                
            }
            .frame(maxHeight:ScreenSize.height/6,alignment: .bottom)
            .edgesIgnoringSafeArea(.top)
            
            
            ScrollView()
            {
                
            }
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
