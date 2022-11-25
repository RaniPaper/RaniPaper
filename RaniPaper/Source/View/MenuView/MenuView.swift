//
//  MenuView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()
    
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
                    if $0.startLocation.x > 310{
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
            Color.black
                .opacity(Double((360-viewModel.Offset))/1300)
                .animation(.easeIn, value: viewModel.Offset)
                .onTapGesture {
                    viewModel.Offset = Menu.minOffset
                }
            
            SideMenuView(isOpen: $viewModel.isOpen, offset: $viewModel.Offset, menuList: viewModel.menuList)
                .offset(x: viewModel.Offset)
                .transition(.move(edge: .trailing))
                .animation(.easeIn, value: viewModel.Offset)
        }
        .gesture(drag)
        .ignoresSafeArea()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

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
