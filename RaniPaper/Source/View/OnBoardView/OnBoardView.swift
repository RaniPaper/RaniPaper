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
    @State var currentView: ViewSelection
    let radius = ScreenSize.width * 0.06
    
    var body: some View {
        ZStack{
            if isOpen{
                ZStack{
                    Color.black.overlay{
                        ScrollView(.horizontal){
                            TabView{
                                ForEach(viewModel.onBoardModels){ model in
                                    if model.view == currentView{
                                        ZStack{
                                            Image(model.images)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                            ExplainView()
                                                .overlay(content: {
                                                    OverlayView(model: model)
                                                })
                                                .offset(y: ScreenSize.height * 0.65)
                                        }
                                    }
                                }
                            }
                            .frame(width: ScreenSize.width, height:  ScreenSize.height)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        }
                    }
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
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            fetch()
        })
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(currentView: .memo)
            .environmentObject(UserState.shared)
    }
}

extension OnBoardView{
    func ExplainView() -> some View {
        Color.onBoardBackground
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(Color.onBoardBorder, lineWidth: 3))
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
    
    func OverlayView(model: OnBoardModel) -> some View{
        GeometryReader{ proxi in
            VStack(spacing: proxi.size.height * 0.01){
                Text("\(model.title)") //title
                    .font(.efDiary(17))
                    .frame(width: proxi.size.width)
                    .padding(.bottom, proxi.size.height * 0.02)
                ForEach(model.contents, id: \.self){ content in
                    Text("\(content)")
                        .font(.efDiary(14))
                        .frame(width: proxi.size.width)
                }
            }
            .fixedSize()
            .padding(.top, proxi.size.height * 0.03)
        }
    }
    
    func fetch(){
        isOpen = MyUserDefaults.shared.getValue(key: currentView.Name + "OnBoard") as? Bool ?? true
    }
}
