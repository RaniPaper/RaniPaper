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
    @StateObject var viewModel: MenuViewModel
    
    var body: some View{
        ZStack(alignment: .leading) {
            Image("sideTab")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack() {
                VStack(alignment: .leading){
                    Spacer()
                        .frame(height: ScreenSize.height * 0.127)
                    ForEach(viewModel.menuList) { menu in
                        if !menu.isUnder {
                            Button(action:{
                                isOpen.toggle()
                                offset = Menu.minOffset
                                selection = menu.viewSelection
                            }) {
                                Image(menu.viewSelection.Name + (selection == menu.viewSelection ? "OnPress" : ""))
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 37, trailing: 0))
                        }
                    }

                    Spacer()
                    
                    ForEach(viewModel.menuList) { menu in
                        if menu.isUnder {
                            Button(action:{
                                isOpen.toggle()
                                offset = Menu.minOffset
                                selection = menu.viewSelection
                            }) {
                                Image(menu.viewSelection.Name + (selection == menu.viewSelection ? "OnPress" : ""))
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
        .animation(.default, value: viewModel.isSettingOn)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SideMenuView(isOpen: .constant(true),
                         offset: .constant(10),
                         selection: .constant(.home),
                         viewModel: MenuViewModel()
                         )
        }
    }
}
