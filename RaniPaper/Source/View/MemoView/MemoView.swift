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
                    
                    VStack(spacing: 0) {
                        Image("memoPenㅋ")
                        Text("기록")
                            .font(.efDiary(30))
                            .foregroundColor(.memoPrimary)
                        Text("(-)")
                            .font(.efDiary(20))
                            .foregroundColor(.memoPrimary)
                            .frame(maxWidth:proxy.size.width)
                            .overlay {
                                HStack{
                                    Text("크게보기").offset(x:thinPadding+5)
                                    Spacer()
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "calendar")
                                    }
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "calendar")
                                    }
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "calendar")
                                    }.padding(.trailing,thinPadding+5)

                                }
                            }
                        
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
