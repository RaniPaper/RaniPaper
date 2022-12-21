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
                if userState.userType == .viichan{
                    Image("viic1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenSize.width * 0.24)
                        .padding(.top, 20)
                    } else {
                    Image("leaves")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenSize.width * 0.24)
                        .padding(.top, 20)
                    }
                ZStack{
                    GeometryReader{ geometry in
                        let height = geometry.size.height
                        Image("settingBG")
                            .resizable()
                            .frame(width: ScreenSize.width)
                            .overlay{
                                VStack(alignment: .leading, spacing: 0){
                                    VStack(alignment: .leading, spacing: height * 0.016){
                                        Section(header:
                                                    Text("온/오프")
                                            .font(.efDiary(height/66.6))
                                            .foregroundColor(.secondary)
                                        ){
                                            VStack(spacing: height * 0.007){
                                                ForEach($viewModel.soundSettingList){ $setting in
                                                    Toggle(isOn: $setting.isOn){
                                                        HStack{
                                                            Text(setting.key)
                                                                .font(.efDiary(height/39))
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
                                                            .font(.efDiary(height/39))
                                                        Spacer()
                                                        Image("animation")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: ScreenSize.width * 0.14)
                                                    }
                                                    .frame(height: ScreenSize.height * 0.04)
                                                    .padding(.top, -height * 0.003)
                                                }
                                                .toggleStyle(MyToggleStyle())
                                            }
                                        }
                                    }
                                    
                                    ForEach(SettingModel.Section.allCases, id: \.self){ section in
                                        VStack(alignment: .leading){
                                            Section(header:
                                                        Text(section.rawValue)
                                                .font(.efDiary(height/66.6))
                                                .foregroundColor(.secondary)
                                                .padding(.bottom, -height * 0.004)
                                            ){
                                                SectionContentView(height, section: section.rawValue)
                                            }
                                        }
                                        .padding(.top, height * 0.09)
                                    }
                                    Spacer()
                                        .padding(.bottom)
                                }
                                .padding(EdgeInsets(top: height * 0.118, leading: ScreenSize.width * 0.2, bottom: 0, trailing: ScreenSize .width * 0.12))
                            }
                            .overlay{
                                VStack(alignment: .trailing, spacing: 0){
                                    Image("settingLeaf")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: height * 0.07)
                                        .padding(.trailing, ScreenSize.width * 0.04)
                                    Rectangle()
                                        .fill(Color.settingBoldLine)
                                        .frame(width: ScreenSize.width * 0.732, height: height * 0.0012)

                                }
                                .offset(x: ScreenSize.width * 0.042,y: geometry.size.height * 0.388)
                            }
                    }
                }
                .frame(height: ScreenSize.height * 0.82)
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
    
    func SectionContentView(_ height: CGFloat, section: String) -> some View{
        VStack(alignment: .leading, spacing: height * 0.007){
            ForEach(viewModel.settingList){ setting in
                if setting.section.rawValue == section {
                    Button(action: {
                        switch setting.action{
                        case .showOnBoard:
                            isOnboardOn = true
                        case .showWebsite:
                            openURL(URL(string: "https://rani-paper.tistory.com/m/category/Rani%20Paper")!)
                        case .ask:
                            openURL(URL(string: "https://forms.gle/n6wsw9H1uK8LMcVw8")!)
                        default:
                            break
                        }
                    }){
                        Text(setting.content)
                            .font(.efDiary(height/39))
                    }
                    .foregroundColor(.black)
                    .frame(height: ScreenSize.height * 0.04)
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
