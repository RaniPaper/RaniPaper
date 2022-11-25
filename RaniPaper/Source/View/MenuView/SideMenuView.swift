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
    let menuList: [String]
    
    var body: some View{
        ZStack() {
            Color.white
            List(){
                ForEach(menuList, id: \.self) { menu in
                    Button(action:{
                        isOpen.toggle()
                    }) {
                        Text(menu)
                            .foregroundColor(.black)
                            .bold()
                            .font(Font.beomsuk(size: 20))
                    }
                }.listRowBackground(Color.clear)
                    .padding(10)
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
        }
        .ignoresSafeArea()
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isOpen: .constant(true),
                     offset: .constant(10),
                     menuList: ["오늘의 할 일",
                                "단어 검색",
                                "다이어리 꾸미기",
                                "설정",
                                "크레딧"])
    }
}
