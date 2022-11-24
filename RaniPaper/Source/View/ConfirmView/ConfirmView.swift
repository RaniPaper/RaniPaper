//
//  ConfirmView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/24.
//

import SwiftUI

struct ConfirmView: View {
    @State var isMenuOpen: Bool = false
    @State var offset: CGFloat = 0
    @State var menuOffset = ScreenSize.width
    var body: some View {
        let drag = DragGesture()
            .onChanged{
                if isMenuOpen{
                    let cmp = Menu.maxOffset - $0.startLocation.x
                    if ($0.translation.width > 0) && (cmp > 0) {
                        menuOffset = Menu.maxOffset + $0.translation.width - cmp
                    }
                    else if ($0.translation.width > 0) && (cmp < 0) {
                        menuOffset = Menu.maxOffset + $0.translation.width
                    }
                } else {
                    if $0.startLocation.x > 320{
                        menuOffset = ScreenSize.width + $0.translation.width > Menu.maxOffset ? ScreenSize.width + $0.translation.width : Menu.maxOffset
                    }
                }
            }
            .onEnded{ _ in
                if self.menuOffset < Menu.threshold{
                    withAnimation{
                        self.isMenuOpen = true
                        self.menuOffset = Menu.maxOffset
                    }
                }
                else {
                    withAnimation{
                        self.isMenuOpen = false
                        self.menuOffset = ScreenSize.width
                    }
                }
        }
        
        ZStack {
            Image("mainTmp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .gesture(drag)
            
            Button( action: {
                self.isMenuOpen.toggle()
                menuOffset = Menu.maxOffset
                }) {
                    Text("Menu Open")
                        .font(Font.efDiary(size: 30))
            }.background(Color(.white))
            
            Color.black
                .opacity(Double((360-self.menuOffset))/1300)
            .animation(.easeIn, value: self.menuOffset)
            .onTapGesture {
                self.menuOffset = ScreenSize.width
            }

            MenuView(isOpen: $isMenuOpen)
                .offset(x: menuOffset)
                .transition(.move(edge: .trailing))
                .animation(.easeIn, value: self.menuOffset)
        }
        .ignoresSafeArea()
        .gesture(drag)
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView()
    }
}
