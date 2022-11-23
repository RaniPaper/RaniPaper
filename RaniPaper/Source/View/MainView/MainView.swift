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
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        withAnimation {
                            viewModel.isLoading.toggle()

                        }
                    }
                }
            }
            else
            {
                Text("Hello")
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
