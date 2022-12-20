//
//  OnBoardView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/20.
//

import SwiftUI

struct OnBoardView: View {
    @EnvironmentObject var userState: UserState
    @ObservedObject var viewModel = OnBoardViewModel()
    @State var isOpen = false
    @State var currentView: ViewSelection{
        didSet{
            print("Did Set")
            isOpen = MyUserDefaults.shared.getValue(key: currentView.Name + "OnBoard") as? Bool ?? true
        }
    }
    
    var body: some View {
        ZStack{
            if isOpen{
                ZStack{
                    TabView(){
                        ForEach(viewModel.onBoardModels){ model in
                            if model.view == currentView{
                                ZStack{
                                    ExplainView()
                                        .overlay(content: {
                                            GeometryReader{ proxi in
                                                VStack(spacing: proxi.size.height * 0.01){
                                                    Text("\(model.title)") //title
                                                        .font(.efDiary(15))
                                                        .frame(width: proxi.size.width)
                                                        .padding(.bottom, proxi.size.height * 0.02)
                                                    ForEach(model.contents, id: \.self){ content in
                                                        Text("\(content)")
                                                            .font(.efDiary(11))
                                                            .frame(width: proxi.size.width)
                                                    }
                                                }
                                                .fixedSize()
                                                .padding(.top, proxi.size.height * 0.03)
                                            }
                                        })
                                        .offset(y: ScreenSize.height * 0.65)
                                }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    Button(action:{
                        isOpen = false
                    }){
                        Text("close")
                    }
                }
                .onAppear{
                    userState.isMenuEnable = false
                }
                .onDisappear{
                    userState.isMenuEnable = true
                    MyUserDefaults.shared.setValue(key: currentView.Name + "OnBoard", value: false)
                }
                .ignoresSafeArea()
            } else{
                EmptyView()
            }
        }
        .onAppear(perform: {
            fetch()
        })
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(currentView: .home)
            .environmentObject(UserState.shared)
    }
}

extension OnBoardView{
    func ExplainView() -> some View {
        ZStack{
            let radius = ScreenSize.width * 0.06
            
            Color.onBoardBackground
                .overlay(RoundedRectangle(cornerRadius: radius)
                    .stroke(Color.onBoardBorder, lineWidth: 3))
                .clipShape(RoundedRectangle(cornerRadius: radius))
        }
    }
    
    func fetch(){
        isOpen = MyUserDefaults.shared.getValue(key: currentView.Name + "OnBoard") as? Bool ?? true
    }
}
