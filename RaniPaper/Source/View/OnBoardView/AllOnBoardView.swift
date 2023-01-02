//
//  AllOnBoardView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/22.
//

import SwiftUI

struct AllOnBoardView: View {
    @EnvironmentObject var userState: UserState
    @ObservedObject var viewModel = OnBoardViewModel()
    @Binding var isOpen: Bool
    let radius = ScreenSize.width * 0.06
    
    var body: some View {
        ZStack{
            Color.onBoardDefault.overlay{
                ScrollView(.horizontal){
                    TabView{
                        ForEach(viewModel.onBoardModels){ model in
                            ZStack{
                                Image(model.images)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                ExplainView()
                                    .overlay(content: {
                                        OverlayView(model: model)
                                    })
                                    .offset(y: ScreenSize.height * 0.72)
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
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.onBoardBorder)
                    .frame(width: ScreenSize.width * 0.05)
                    .padding(ScreenSize.width * 0.02)
            }
            .padding(ScreenSize.width * 0.02)
            .offset(x: ScreenSize.width * 0.4, y: -ScreenSize.height * 0.42)
        }
        .frame(width: ScreenSize.width, height:  ScreenSize.height)
        .onAppear{
            userState.isMenuEnable = false
        }
        .onDisappear{
            userState.isMenuEnable = true
        }
        .ignoresSafeArea()
    }
}

struct AllOnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        AllOnBoardView(isOpen: .constant(true))
            .environmentObject(UserState.shared)
    }
}

extension AllOnBoardView{
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
                    .font(.efDiary(proxi.size.width * 0.045))
                    .frame(width: proxi.size.width)
                    .padding(.bottom, proxi.size.height * 0.04)
                ForEach(model.contents, id: \.self){ content in
                    if !content.isEmpty{
                        Text("\(content)")
                            .font(.efDiary(proxi.size.width * 0.035))
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
                switch model.view{
                case .memo:
                    if model.page == 1{
                        RoundedRectangle(cornerRadius: proxi.size.height * 0.05)
                            .strokeBorder()
                            .frame(width: proxi.size.width * 0.31, height: proxi.size.height * 0.03)
                            .foregroundColor(.onBoardRed)
                            .offset(x: -proxi.size.width * 0.075, y: proxi.size.height * 0.063)
                    } else if model.page == 4{
                        Image("memoSave")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxi.size.width * 0.05)
                            .offset(x: -proxi.size.width * 0.2, y: proxi.size.height * 0.074)
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
                            .offset(x: -proxi.size.width * 0.31, y: proxi.size.height * 0.108)
                    } else if model.page == 2{
                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .frame(width: proxi.size.width * 0.06)
                            .foregroundColor(.onBoardRed)
                            .offset(x: -proxi.size.width * 0.437, y: -proxi.size.height * 0.051)
                    }
                default:
                    EmptyView()
                }
            }
        }
    }
}
