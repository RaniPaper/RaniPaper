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
            
            Image("settingBG")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ScreenSize.width)
                .offset(y: ScreenSize.height * 0.06)
            
            Image("viic1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ScreenSize.width * 0.24)
                .offset(y: -ScreenSize.height * 0.395)
            
            Image("settingLeaf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ScreenSize.width * 0.2)
                .offset(x: ScreenSize.width * 0.26, y: ScreenSize.height * 0.38)
            
            VStack(alignment: .center, spacing: 0){
                VStack(alignment: .leading, spacing: ScreenSize.height * 0.008){
                    Section(header:
                        Text("온/오프")
                            .font(.efDiary(10))
                            .foregroundColor(.secondary)
                        ){
                        VStack(spacing: ScreenSize.height * 0.007){
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
                        .frame(height: ScreenSize.height * 0.062)
                    
                    SettingListView()
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: ScreenSize.height * 0.03, leading: ScreenSize.width * 0.13, bottom: ScreenSize.height * 0.06, trailing: ScreenSize .width * 0.05))
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.7)
                .offset(y: ScreenSize.height * 0.06)
            }
            .padding(.top, ScreenSize.height * 0.01)
            
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
    func SettingListView() -> some View{
        ForEach(SettingModel.Section.allCases, id: \.self){ section in
            VStack(alignment: .leading, spacing: ScreenSize.height * 0.01){
                Section(header:
                            Text(section.rawValue)
                    .font(.efDiary(10))
                    .foregroundColor(.secondary)
                ){
                    SectionContentView(section: section.rawValue)
                }
            }
        }
    }
    
    func SectionContentView(section: String) -> some View{
        VStack(alignment: .leading, spacing: ScreenSize.height * 0.021){
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
