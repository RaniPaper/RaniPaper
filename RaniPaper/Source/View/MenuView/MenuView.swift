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
                    }
                }
            }
            .onEnded{ _ in
                if viewModel.Offset < Menu.threshold{
                    withAnimation{
                        viewModel.isOpen = true
                        viewModel.Offset = Menu.maxOffset
                    }
                }
                else {
                    withAnimation{
                        viewModel.isOpen = false
                        viewModel.Offset = Menu.minOffset
                    }
                }
            }
        ZStack{
            Color.white.opacity(0.1)
            Color.black
                .opacity(Double((360-viewModel.Offset))/1300)
                .animation(.easeIn, value: viewModel.Offset)
                .onTapGesture {
                    viewModel.Offset = Menu.minOffset
                }
            
            SideMenuView(isOpen: $viewModel.isOpen,
                         offset: $viewModel.Offset,
                         selection: $selection,
                         menuList: viewModel.menuList)
            .offset(x: viewModel.Offset)
            .transition(.move(edge: .trailing))
            .animation(.linear, value: viewModel.Offset)
        }
        .gesture(drag)
        .ignoresSafeArea()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(selection: .constant(.home))
    }
}


