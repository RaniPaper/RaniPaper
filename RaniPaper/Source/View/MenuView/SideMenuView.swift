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
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0){
                    Spacer()
                        .frame(height: ScreenSize.height * 0.225)
                    
                    // - MARK: UpSide Menu
                    VStack(alignment: .leading, spacing: ScreenSize.height * 0.0565){
                        ForEach(viewModel.menuList) { menu in
                            if !menu.isUnder {
                                Button(action:{
                                    isOpen.toggle()
                                    offset = Menu.minOffset
                                    MySoundSetting.clickSideMenu.play()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        selection = menu.viewSelection
                                    }
                                }) {
                                    Image(menu.viewSelection.Name + (selection == menu.viewSelection ? "OnPress" : ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: ScreenSize.height * 0.044)
                                }
                            }
                        }
                    }

                    Spacer()
                    
                    // - MARK: DownSide Menu
                    VStack(alignment: .leading, spacing: ScreenSize.height * 0.008){
                        ForEach(viewModel.menuList) { menu in
                            if menu.isUnder {
                                Button(action:{
                                    isOpen.toggle()
                                    offset = Menu.minOffset
                                    MySoundSetting.clickSideMenu.play()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        selection = menu.viewSelection
                                    }
                                }) {
                                    Image(menu.viewSelection.Name + (selection == menu.viewSelection ? "OnPress" : ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: ScreenSize.height * 0.044)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: ScreenSize.height * 0.004, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                        .frame(height: ScreenSize.height * 0.128)
                }
                .padding(EdgeInsets(top: 0, leading: ScreenSize.width * 0.13, bottom: 0, trailing: 0))
                
                Spacer()
            }
        }
        .frame(height: ScreenSize.height)
        .ignoresSafeArea()
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

extension SideMenuView{
    func TabButtonView(menu: MenuContent) -> some View{
        HStack(spacing: 10){
//            Image(menu.viewSelection.Name)
            Image("viichan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: ScreenSize.height * 0.044)
            Text(menu.viewSelection.ButtonName)
                .font(.efDiary(ScreenSize.width * 0.067))
                .padding(.trailing, ScreenSize.width * 0.02)
        }
        .overlay{
            if selection == menu.viewSelection{
                if selection == .home{
                    Color.menuHomeOnPress.opacity(0.4)
                } else if selection == .credit{
                    Color.menuCreditOnPress.opacity(0.4)
                } else{
                    Color.menuOnPress
                }
            }
        }
    }
}
