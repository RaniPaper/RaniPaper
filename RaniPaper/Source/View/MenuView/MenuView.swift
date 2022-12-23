//
//  MenuView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userState: UserState
    @StateObject var viewModel = MenuViewModel()
    @Binding var selection: ViewSelection
    @State var isPlayed = false
    @State var gestureState: String = ""
    var body: some View {
                
        let drag = DragGesture()
            .onChanged{
                gestureState = "OnChanged"
                if viewModel.isOpen{
                    let cmp = Menu.maxOffset - $0.startLocation.x
                    if ($0.translation.width > 0) && (cmp > 0) {
                        viewModel.Offset = Menu.maxOffset + $0.translation.width - cmp
                    }
                    else if ($0.translation.width > 0) && (cmp < 0) {
                        viewModel.Offset = Menu.maxOffset + $0.translation.width
                    }
                } else {
                    if $0.startLocation.x > Menu.openEdge{
                        viewModel.Offset = Menu.minOffset + $0.translation.width > Menu.maxOffset ? Menu.minOffset + $0.translation.width : Menu.maxOffset
                        if !isPlayed{
                            MySoundSetting.openSideMenu.play()
                            isPlayed = true
                        }
                    }
                }
            }
            .onEnded{ _ in
                gestureState = "OnEnded"
                if viewModel.Offset < (viewModel.isOpen ? Menu.closeThreshold : Menu.openThreshold){
                    withAnimation{
                        viewModel.Offset = Menu.maxOffset
                        viewModel.isOpen = true
                    }
                }
                else {
                    withAnimation{
                        if viewModel.isOpen{
                            MySoundSetting.closeSideMenu.play()
                        }
                        viewModel.isOpen = false
                        viewModel.Offset = Menu.minOffset
                    }
                }
                isPlayed = false
            }
        
        ZStack{
            Color.black
                .opacity(viewModel.Offset == Menu.minOffset ? 0 : Double((ScreenSize.width-viewModel.Offset))/1300)
                .animation(.easeIn, value: viewModel.Offset)
                .onTapGesture {
                    viewModel.Offset = Menu.minOffset
                    viewModel.isOpen = false
                    MySoundSetting.closeSideMenu.play()
                }
            
            SideMenuView(isOpen: $viewModel.isOpen,
                         offset: $viewModel.Offset,
                         selection: $selection,
                         viewModel: viewModel)
            .shadow(radius: 3)
            .offset(x: viewModel.Offset)
            .transition(.move(edge: .trailing))
            .animation(.linear, value: viewModel.Offset)
            
            Text(gestureState)
        }
        .contentShape(Rectangle())
        .highPriorityGesture(userState.isMenuEnable ? drag : nil)
        .ignoresSafeArea()
    }
}

struct prev: View{
    @State var select: ViewSelection = .home
    var body: some View{
        MenuView(selection: $select)
            .environmentObject(UserState.shared)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            prev()
        }
    }
}
