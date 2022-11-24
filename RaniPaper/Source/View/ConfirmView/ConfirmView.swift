//
//  ConfirmView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/24.
//

import SwiftUI

struct ConfirmView: View {
    @State var isMenuOpen: Bool = false
    var body: some View {
        ZStack {
            Button( action: {
                self.isMenuOpen.toggle()
                }) {
                    Text("Open Menu")
                        .font(Font.efDiary(size: 10))
            }
            
            Color.black
            .opacity(self.isMenuOpen ? 0.2 : 0)
            .animation(.easeIn, value: self.isMenuOpen)
            .onTapGesture {
                    self.isMenuOpen.toggle()
            }
            // isMenuOpen 상태에 따라 MenuView display
            if self.isMenuOpen{
                MenuView(isOpen: $isMenuOpen)
                    .offset(x: ScreenSize.width * 0.45)
                    .transition(.move(edge: .trailing))
                    .animation(.easeIn(duration: 0.5).delay(0.25), value: self.isMenuOpen)
            }
        }
        .ignoresSafeArea()
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView()
    }
}
