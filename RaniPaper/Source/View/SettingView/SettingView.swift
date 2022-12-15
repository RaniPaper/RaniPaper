//
//  SettingView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userState: UserState
    @Environment(\.openURL) var openURL
    @ObservedObject var viewModel = SettingViewModel()
    @State var isOnboardOn = false
    var body: some View {
        ZStack{
            Image("main_static")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 5)
            VStack(spacing: 0){
                Image("viic1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ScreenSize.width * 0.24)
                    .padding(.top, 20)
                
                ZStack{
                    GeometryReader{ geometry in
                        let height = geometry.size.height
                        Image("settingBG")
                            .resizable()
                            .frame(width: ScreenSize.width)
                            .overlay{
                                VStack(alignment: .center, spacing: 0){
                                    VStack(alignment: .leading, spacing: height * 0.014){
                                        Section(header:
                                                    Text("온/오프")
                                            .font(.efDiary(10))
                                            .foregroundColor(.secondary)
                                        ){
                                            VStack(spacing: height * 0.007){
                                                ForEach($viewModel.soundSettingList){ $setting in
                                                    Toggle(isOn: $setting.isOn){
                                                        HStack{
                                                            Text(setting.key)
                                                                .font(.efDiary(17))
                                                            Spacer()
                                                            Image(setting.getUIName())
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: ScreenSize.width * 0.14)
                                                        }
                                                        .frame(height: ScreenSize.height * 0.04)
                                                    }
                                                    .toggleStyle(MyToggleStyle())
                                                }
                                                Toggle(isOn: $viewModel.isAnimationOn){
                                                    HStack{
                                                        Text("애니메이션")
                                                            .font(.efDiary(17))
                                                        Spacer()
                                                        Image("animation")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: ScreenSize.width * 0.14)
                                                    }
                                                    .frame(height: ScreenSize.height * 0.04)
                                                }
                                                .toggleStyle(MyToggleStyle())
                                            }
                                        }
                                        
                                        Spacer()
                                            .frame(height: height * 0.062)
                                        
                                        SettingListView(height)
                                        
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: height * 0.038, leading: ScreenSize.width * 0.13, bottom: 0, trailing: ScreenSize .width * 0.05))
                                    .frame(width: ScreenSize.width * 0.9, height: height * 0.85)
                                }
                                .padding(.top, height * 0.01)
                            }
                    
                        Image("settingLeaf")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: height * 0.07)
                            .offset(x: geometry.size.width * 0.7, y: geometry.size.height * 0.85)
                    }
                    .frame(height: ScreenSize.height * 0.82)
                }
            }
            //온보딩 화면 display 구현 부분
            if isOnboardOn{
                DummyView1()
                    .onTapGesture {
                        isOnboardOn = false
                    }
            }
        }
        .ignoresSafeArea()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(UserState.shared)
    }
}

extension SettingView{
    func SettingListView(_ height: CGFloat) -> some View{
        ForEach(SettingModel.Section.allCases, id: \.self){ section in
            VStack(alignment: .leading, spacing: height * 0.012){
                Section(header:
                            Text(section.rawValue)
                    .font(.efDiary(10))
                    .foregroundColor(.secondary)
                ){
                    SectionContentView(height, section: section.rawValue)
                }
            }
        }
    }
    
    func SectionContentView(_ height: CGFloat, section: String) -> some View{
        VStack(alignment: .leading, spacing: height * 0.02){
            ForEach(viewModel.settingList){ setting in
                if setting.section.rawValue == section {
                    Button(action: {
                        switch setting.action{
                        case .showOnBoard:
                            isOnboardOn = true
                        case .showWebsite:
                            openURL(URL(string: "https://rani-paper.tistory.com/m/category/Rani%20Paper")!)
                        case .ask:
                            openURL(URL(string: "https://cafe.naver.com/steamindiegame")!)
                        default:
                            break
                        }
                    }){
                        Text(setting.content)
                            .font(.efDiary(17))
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

extension SettingView{
    // 커스텀 토글 버튼
    struct MyToggleStyle: ToggleStyle{
        private let width = ScreenSize.width * 0.15
        
        func makeBody(configuration: Configuration) -> some View {
            return HStack{
                configuration.label
                
                ZStack(alignment: configuration.isOn ? .trailing : .leading){
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width, height: width/2.3)
                        .foregroundColor(configuration.isOn ? .settingToggleOn : .settingToggleOff)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width/1.8, height: width/2.3-2)
                        .padding(1)
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation{
                                configuration.$isOn.wrappedValue.toggle()
                            }
                        }
                }
            }
        }
    }
}
