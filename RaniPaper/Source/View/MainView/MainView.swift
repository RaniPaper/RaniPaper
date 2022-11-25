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
                NavigationView {
                    ZStack{
                        TabView(selection: $viewModel.selection){
                            Image("mainTmp")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .tag(ViewSelection.home)
                            DummyView1() //테스트용으로 만든 더미 뷰
                                .tag(ViewSelection.diary)
                            DummyView2() //해당 부분에 전환할 view 입력
                                .tag(ViewSelection.memo)
                                //tag 내부에 view를 구분할 수 있는 tag 입력, constant에서 새로 생성 가능
                        }
                        .transition(.slide)
                        .animation(.linear, value: viewModel.selection)
                        MenuView(selection: $viewModel.selection)
                    }
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
