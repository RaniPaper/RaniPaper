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
            if viewModel.isLoading {
                LaunchView().transition(.opacity)
                    .environmentObject(userState)
                    .onAppear {
                        // 앱 진입 시 유저디폴트에 롤링페이퍼가 없을 경우 롤링페이퍼 불러오기
                        if MyUserDefaults.rollingPaperList == nil {
                            MyUserDefaults.rollingPaperList = rollingPaperList
                            print("롤링페이퍼", MyUserDefaults.rollingPaperList?.count ?? "🔥", "개를 불러옵니다.")
                        }
                        
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("Noti Tabbed"), object: nil, queue: .main){(_) in
                            viewModel.selection = .diary
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            withAnimation { viewModel.isLoading.toggle() }
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
                }
                .overlay{
                    MenuView(selection: $viewModel.selection)
                }
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification, object: nil)){(_) in
//                    print("Test")
//                    
//                }
                .environmentObject(UserState.shared)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserState.shared)
    }
}
