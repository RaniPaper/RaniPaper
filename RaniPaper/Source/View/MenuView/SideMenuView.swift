//
//  SideMenuView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isOpen: Bool
    @Binding var offset: CGFloat
    let menuList: [MenuContent]
    
    var body: some View{
        ZStack() {
            Color.white
            HStack() {
                VStack(alignment: .leading){
                    ForEach(menuList) { menu in
                        if !menu.isUnder{
                            if !menu.isSetting {
                                Button(action:{
                                    isOpen.toggle()
                                    offset = Menu.minOffset
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(Font.beomsuk(size: 24))
                                }
                            } else {
                                Button(action:{
                                    
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(Font.beomsuk(size: 24))
                                }
                            }
                        }
                    }
                    .padding(10)
                    
                    Spacer().frame(height: ScreenSize.height * 0.48)
                    
                    ForEach(menuList) { menu in
                        if menu.isUnder {
                            Button(action:{
                                isOpen.toggle()
                                offset = Menu.minOffset
                            }) {
                                Text(menu.title)
                                    .foregroundColor(.secondary)
                                    .font(Font.beomsuk(size: 20))
                            }
                        }
                        
                    }
                    .padding(5)
                }
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
                
                Spacer().frame(width: ScreenSize.width * 0.6)
            }
        }
        .ignoresSafeArea()
        .frame(height: ScreenSize.height)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isOpen: .constant(true),
                     offset: .constant(10),
                     menuList:[MenuContent(title: "홈",                                                   navigationPath: "홈"),
                               MenuContent(title: "다이어리", navigationPath: "다이어리"),
                               MenuContent(title: "기록", navigationPath: "기록"),
                               MenuContent(title: "설정", navigationPath: "설정", isSetting: true),
                               MenuContent(title: "앱정보", navigationPath: "앱정보", isUnder: true),
                               MenuContent(title: "크레딧", navigationPath: "크레딧", isUnder: true)]
        )
    }
}
