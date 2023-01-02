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
        
        ZStack{
            if userState.isMenuEnable{
                Button(action:{
                    if !viewModel.isOpen{
                        viewModel.isOpen = true
                        viewModel.Offset = Menu.maxOffset
                    } else{
                        
                    }
                }){
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenSize.width * 0.045)
                        .foregroundColor(Color.black)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .padding(ScreenSize.width * 0.05)
                }
                .offset(x: ScreenSize.width * 0.4, y: -ScreenSize.height * 0.4)
            }
            
            Color.black
                .opacity(viewModel.Offset == Menu.minOffset ? 0 : Double((ScreenSize.width-viewModel.Offset))/1300+0.05)
                .animation(.easeIn, value: viewModel.Offset)
                .gesture(TapGesture().onEnded{
                    if viewModel.isOpen{
                        MySoundSetting.closeSideMenu.play()
                        viewModel.Offset = Menu.minOffset
                        viewModel.isOpen = false
                    }
                })
            
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
        .modifier(DragGestureViewModifier(offset: $viewModel.Offset, isOpen: $viewModel.isOpen))
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

struct DragGestureViewModifier: ViewModifier{
    @GestureState private var isDragging: Bool = false
    @State var gestureState: GestureStatus = .idle
    @State var isPlayed = false
    @Binding var offset: CGFloat
    @Binding var isOpen: Bool
    
    var onUpdate: ((DragGesture.Value) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .updating($isDragging){_, isDragging, _ in
                        isDragging = true
                    }
                    .onChanged(onDragChange(_:))
                    .onEnded(onDragEnded(_:))
            )
            .onChange(of: gestureState){ state in
                guard state == .started else {return}
                gestureState = .active
                
            }
            .onChange(of: isDragging){ value in
                if value, gestureState != .started{
                    gestureState = .started
                } else if !value, gestureState != .ended{
                    gestureState = .cancelled
                    onCancled()
                }
            }
    }
        
    func onDragChange(_ value: DragGesture.Value){
        guard gestureState == .started || gestureState == .active else {return}
        onUpdate(value: value)
    }
        
    func onDragEnded(_ value: DragGesture.Value){
        gestureState = .ended
        onEnd()
    }
    
    func onUpdate(value: DragGesture.Value){
        if isOpen{
            let cmp = Menu.maxOffset - value.startLocation.x
            if (value.translation.width > 0) && (cmp > 0) {
                offset = max(Menu.maxOffset + value.translation.width - cmp, Menu.maxOffset)
            }
            else if (value.translation.width > 0) && (cmp < 0) {
                offset = max(Menu.maxOffset + value.translation.width, Menu.maxOffset)
            }
            else{
                offset = Menu.maxOffset
            }
        } else {
            if value.startLocation.x > Menu.openEdge{
                offset = max(Menu.minOffset + value.translation.width, Menu.maxOffset)
                if !isPlayed{
                    MySoundSetting.openSideMenu.play()
                    isPlayed = true
                }
            }
        }
    }
    
    func onEnd(){
        if offset < (isOpen ? Menu.closeThreshold : Menu.openThreshold){
            withAnimation{
                offset = Menu.maxOffset
                isOpen = true
            }
        }
        else {
            if isOpen{
                MySoundSetting.closeSideMenu.play()
            }
            withAnimation{
                isOpen = false
                offset = Menu.minOffset
            }
        }
        isPlayed = false
    }
    
    func onCancled(){
        onEnd()
    }
    
    enum GestureStatus: Equatable{
        case idle, started, active, ended, cancelled
    }
}
