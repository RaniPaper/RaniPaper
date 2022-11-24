//
//  ContentView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/20.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        
        if viewModel.lockState == .locked {
            LockView(lockState: $viewModel.lockState)
                .transition(.opacity)
                
                
                
        }
        else{
            if viewModel.isLoading{
                LaunchView().transition(.opacity).onAppear{
                    for family: String in UIFont.familyNames{
                        print(family)
                        for names : String in UIFont.fontNames(forFamilyName: family){
                            print("=== \(names)")
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        withAnimation {
                            viewModel.isLoading.toggle()

                        }
                    }
                }
            }
            else
            {
                ZStack{
                    Image("mainTmp")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                ZStack {
                    Button( action: {
                        viewModel.isMenuOpen.toggle()
                        }) {
                            Text("Open Menu")
                    }
                    
                    Color.black
                    .opacity(viewModel.isMenuOpen ? 0.2 : 0)
                    .animation(.easeIn, value: viewModel.isMenuOpen)
                    .onTapGesture {
                            viewModel.isMenuOpen.toggle()
                    }
                    // isMenuOpen 상태에 따라 MenuView display
                    if viewModel.isMenuOpen{
                        MenuView(isOpen: $viewModel.isMenuOpen)
                            .offset(x: ScreenSize.width * 0.45)
                            .transition(.move(edge: .trailing))
                            .animation(.easeIn(duration: 0.5).delay(0.25), value: viewModel.isMenuOpen)
                    }
                }
                .ignoresSafeArea()
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
