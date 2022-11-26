//
//  ContentView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/20.
//

import SwiftUI


struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var isHome: Bool = true
    
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
                        HStack{
                            Image("mainTmp")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            NavigationLink(tag: ViewSelection.diary, selection: $viewModel.selection,
                                           destination: {
                                DummyView1() //다이어리 뷰로 대체
                                    .navigationBarBackButtonHidden(true)
                                }
                            ){EmptyView()}
                            
                            NavigationLink(tag: ViewSelection.memo, selection: $viewModel.selection,
                                           destination: {
                                DummyView2()//기록 뷰로 대체
                                    .navigationBarBackButtonHidden(true)
                            }){EmptyView()}
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
