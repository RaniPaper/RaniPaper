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
    @Binding var isSettingOpen: Bool
    @Binding var selection: ViewSelection
    @StateObject var viewModel = SideMenuViewModel()
    
    var body: some View{
        ZStack() {
            Color.white
                .onTapGesture {
                    isSettingOpen = false
                }
            HStack() {
                VStack(alignment: .leading){
                    ForEach(viewModel.menuList) { menu in
                        if !menu.isUnder {
                            if !menu.isSetting {
                                Button(action:{
                                    isOpen.toggle()
                                    isSettingOpen = false
                                    offset = Menu.minOffset
                                    selection = menu.viewSelection
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.beomsuk(24))
                                        .frame(width: 100, height: 40, alignment: .leading)
                                }
                            } else {
                                Button(action:{
                                    isSettingOpen.toggle()
                                }) {
                                    Text(menu.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.beomsuk(24))
                                        .frame(width: 100, height: 40, alignment: .leading)
                                }
                                
                            }
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 3){
                        if isSettingOpen && isOpen {
                            ForEach(viewModel.settingList,id: \.self){ setting in
                                Button(action: {
                                    if setting == "배경음"{
                                        viewModel.isBgmOn.toggle()
                                    }
                                }){
                                    if setting == "배경음"{
                                        let label = "-   \(setting)" + (viewModel.isBgmOn ? " ON" : " OFF")
                                        Text("\(label)")
                                            .foregroundColor(.black)
                                            .font(.beomsuk(14))
                                            .frame(width: 100, height: 25, alignment: .leading)
                                    } else {
                                        let label = "-   \(setting) ON"
                                        Text("\(label)")
                                            .foregroundColor(.black)
                                            .font(.beomsuk(14))
                                            .frame(width: 100, height: 25, alignment: .leading)
                                    }
                                }

                            }
                            
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
                                    .frame(width: 100, height: 30, alignment: .leading)
                            }
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 80, leading: 30, bottom: 60, trailing: 50))
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .frame(height: ScreenSize.height)
        .animation(.spring(), value: isSettingOpen)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SideMenuView(isOpen: .constant(true),
                         offset: .constant(10),
                         isSettingOpen: .constant(true),
                         selection: .constant(.home)
                         )
        }
    }
}
