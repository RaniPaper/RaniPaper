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
    @Binding var selection: ViewSelection
    @StateObject var viewModel = SideMenuViewModel()
    
    var body: some View{
        ZStack() {
            Color.white
            HStack() {
                VStack(alignment: .leading){
                    ForEach(viewModel.menuList) { menu in
                        if !menu.isUnder{
                            if !menu.isSetting {
                                Button(action:{
                                    isOpen.toggle()
                                    offset = Menu.minOffset
                                    selection = menu.viewSelection
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.beomsuk(24))
                                }
                            } else {
                                Button(action:{
                                    viewModel.isSettingOn.toggle()
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.beomsuk(24))
                                }
                            }
                        }
                    }
                    .padding(10)
                    
                    
                    VStack(alignment: .leading, spacing: 3){
                        if viewModel.isSettingOn {
                            ForEach(viewModel.settingList,id: \.self){ setting in
                                Button(action: {
                                    
                                }){
                                    Text("-   \(setting)")
                                        .foregroundColor(.black)
                                        .font(.beomsuk(14))
                                }
                            }
                            .padding(8)
                            .transition(.move(edge: .top))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 60, trailing: 0))
                    
                    Spacer()
                    
                    ForEach(viewModel.menuList) { menu in
                        if menu.isUnder {
                            Button(action:{
                                isOpen.toggle()
                                offset = Menu.minOffset
                            }) {
                                Text(menu.title)
                                    .foregroundColor(.secondary)
                                    .font(.beomsuk(20))
                            }
                        }
                        
                    }
                    .padding(5)
                }
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 60, trailing: 0))
                
                Spacer().frame(width: ScreenSize.width * 0.6)
            }
        }
        .ignoresSafeArea()
        .frame(height: ScreenSize.height)
        .animation(.default, value: viewModel.isSettingOn)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SideMenuView(isOpen: .constant(true),
                         offset: .constant(10),
                         selection: .constant(.home)
            )
        }
    }
}
