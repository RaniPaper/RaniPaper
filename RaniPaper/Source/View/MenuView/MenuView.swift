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
    @GestureState var dragState: (CGFloat, Bool) = (Menu.minOffset, false)
    @State var isPlayed = false
    var body: some View {
                
        let drag = DragGesture(minimumDistance: 20)
            .updating($dragState){(value, state, transcation) in
                state.1 = true
                if viewModel.isOpen{
                    let cmp = Menu.maxOffset - value.startLocation.x
                    if (value.translation.width > 0) && (cmp > 0) {
                        state.0 = Menu.maxOffset + value.translation.width - cmp
                    }
                    else if (value.translation.width > 0) && (cmp < 0) {
                        state.0 = Menu.maxOffset + value.translation.width
                    }
                } else {
                    if value.startLocation.x > Menu.openEdge{
                        state.0 = Menu.minOffset + value.translation.width > Menu.maxOffset ? Menu.minOffset + value.translation.width : Menu.maxOffset
                    }
                }
            }
            .onChanged{
                if !viewModel.isOpen{
                    if $0.startLocation.x > Menu.openEdge && !isPlayed{
                        MySoundSetting.openSideMenu.play()
                        isPlayed = true
                    }
                }
                viewModel.Offset = dragState.0
            }
            .onEnded{ _ in
                if viewModel.Offset < (viewModel.isOpen ? Menu.closeThreshold : Menu.openThreshold){
                    withAnimation{
                        viewModel.Offset = Menu.maxOffset
                        viewModel.isOpen = true
                    }
                }
                else {
                    if viewModel.isOpen{
                        MySoundSetting.closeSideMenu.play()
                    }
                    withAnimation{
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
                    if viewModel.isOpen{
                        MySoundSetting.closeSideMenu.play()
                        viewModel.Offset = Menu.minOffset
                        viewModel.isOpen = false
                    }
                }
            
            SideMenuView(isOpen: $viewModel.isOpen,
                         offset: $viewModel.Offset,
                         selection: $selection,
                         viewModel: viewModel)
            .shadow(radius: 3)
            .offset(x: dragState.1 ? dragState.0 : viewModel.Offset)
            .transition(.move(edge: .trailing))
            .animation(.linear, value: viewModel.Offset)
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
