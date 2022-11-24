//
//  MenuView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack() {
            Color.white
            List(){
                ForEach(viewModel.menuList, id: \.self) { menu in
                    Button(action:{
                        
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isOpen: .constant(true))
    }
}
