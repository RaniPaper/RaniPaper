//
//  ContentView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/20.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var userState: UserState
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        
        if userState.userType == .none {
            ConfirmView().environmentObject(userState)

        }
        else{
            if viewModel.isLoading{
                LaunchView().transition(.opacity).onAppear{
//                    for family: String in UIFont.familyNames{
//                        print(family)
//                        for names : String in UIFont.fontNames(forFamilyName: family){
//                            print("=== \(names)")
//                        }
//                    }

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
                        switch viewModel.selection {
                        case .home:
                            HomeView()
                        
                        case .diary:
                            CalendarView()
                            
                        case .memo:
                            MemoView()
                            
                        case .setting:
                            SettingView()
                            
                        case .info:
                            InfoView()
                            
                        case .credit:
                            CreditView()
                        }
                    }
                    MenuView(selection: $viewModel.selection)
                }.environmentObject(UserState.shared)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserState.shared)
    }
}
