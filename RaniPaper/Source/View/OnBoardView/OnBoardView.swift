//
//  OnBoardView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/20.
//

import SwiftUI

struct OnBoardView: View {
    @EnvironmentObject var userState: UserState
    @StateObject var viewModel = OnBoardViewModel()
    @State var isOpen = false
    @State var currentView: ViewSelection
    let radius = ScreenSize.width * 0.06
    
    var body: some View {
        ZStack{
            if isOpen{
                ZStack{
                    Color.onBoardDefault.overlay{
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
                        .overlay(content: {
                            Button(action:{
                                isOpen = false
                            }){
                                Image(systemName: "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.onBoardBorder)
                                    .frame(width: ScreenSize.width * 0.05)
                                    .padding(20)
                            }
                            .padding(10)
                            .offset(x: ScreenSize.width * 0.4, y: -ScreenSize.height * 0.42)
                        })
                    }
                }
                .frame(width: ScreenSize.width, height:  ScreenSize.height)
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
            print("isOpen: \(isOpen)")
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
                    .padding(.bottom, proxi.size.height * 0.04)
                ForEach(model.contents, id: \.self){ content in
                    if !content.isEmpty{
                        Text("\(content)")
                            .font(.efDiary(14))
                            .frame(width: proxi.size.width)
                    } else{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: proxi.size.height * 0.01)
                    }
                }
            }
            .fixedSize()
            .padding(.top, proxi.size.height * 0.03)
            .overlay{
                switch currentView{
                case .memo:
                    if model.page == 1{
                        RoundedRectangle(cornerRadius: proxi.size.height * 0.05)
                            .strokeBorder()
                            .frame(width: proxi.size.width * 0.335, height: proxi.size.height * 0.03)
                            .foregroundColor(.onBoardRed)
                            .offset(x: -proxi.size.width * 0.078, y: proxi.size.height * 0.065)
                    } else if model.page == 4{
                        Image("memoSave")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxi.size.width * 0.05)
                            .offset(x: -proxi.size.width * 0.23, y: proxi.size.height * 0.074)
                    }
                    else {
                        EmptyView()
                    }
                case .diary:
                    if model.page == 1{
                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .frame(width: proxi.size.width * 0.06)
                            .foregroundColor(.onBoardGreen)
                            .offset(x: -proxi.size.width * 0.338, y: proxi.size.height * 0.112)
                    } else if model.page == 2{
                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .frame(width: proxi.size.width * 0.06)
                            .foregroundColor(.onBoardRed)
                            .offset(x: -proxi.size.width * 0.44, y: -proxi.size.height * 0.054)
                    }
                default:
                    EmptyView()
                }
            }
        }
    }
    
    func fetch(){
        isOpen = MyUserDefaults.shared.getValue(key: currentView.Name + "OnBoard") as? Bool ?? true
    }
}
