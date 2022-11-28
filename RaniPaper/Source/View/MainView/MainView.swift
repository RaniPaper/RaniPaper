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
            ConfirmView(lockState: $viewModel.lockState)

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
                    NavigationView{
                        TabView(selection: $viewModel.selection){
                            Image("mainTmp")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .tag(ViewSelection.home)
                            
                            CalendarView()// 다이어리 뷰로 대체
                                .tag(ViewSelection.diary)
                            
                            MemoView()// 기록 뷰로 대체
                                .tag(ViewSelection.memo)
                        }
                    }
                    MenuView(selection: $viewModel.selection)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
