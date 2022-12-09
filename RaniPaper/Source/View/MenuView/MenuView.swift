//
//  MenuView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    @Binding var selection: ViewSelection
    @State var isPlayed = false
    var body: some View {
                
        let drag = DragGesture()
            .onChanged{
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
                if viewModel.Offset < Menu.threshold{
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
                }
            
            SideMenuView(isOpen: $viewModel.isOpen,
                         offset: $viewModel.Offset,
                         selection: $selection,
                         viewModel: viewModel)
            .shadow(radius: 3)
            .offset(x: viewModel.Offset)
            .transition(.move(edge: .trailing))
            .animation(.linear, value: viewModel.Offset)
        }
        .contentShape(Rectangle())
        .gesture(drag)
        .ignoresSafeArea()
    }
}

struct prev: View{
    @State var select: ViewSelection = .home
    var body: some View{
        MenuView(selection: $select)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            prev()
        }
    }
}

extension DragGesture{
    func playOpenSound(isOpen: Bool) -> some Gesture{
        if !isOpen{
            MySoundSetting.openSideMenu.play()
        }
        return self
    }
}
