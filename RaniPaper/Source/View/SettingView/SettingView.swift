//
//  SettingView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userState: UserState
    @ObservedObject var viewModel = SettingViewModel()
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
            
            VStack(alignment: .center, spacing: 0){
                VStack(alignment: .leading, spacing: ScreenSize.height * 0.007){
                    Section(header:
                        Text("온/오프")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ){
                        VStack(spacing: ScreenSize.height * 0.005){
                            ForEach($viewModel.soundSettingList){ $setting in
                                Toggle(isOn: $setting.isOn){
                                    HStack{
                                        Text(setting.key)
                                        Spacer()
                                        Image(setting.getUIName())
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: ScreenSize.width * 0.14)
                                    }
                                    .frame(height: ScreenSize.height * 0.04)
                                }
                            }
                            Toggle(isOn: $viewModel.isAnimationOn){
                                HStack{
                                    Text("애니메이션")
                                    Spacer()
                                    Image("animation")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: ScreenSize.width * 0.14)
                                }
                                .frame(height: ScreenSize.height * 0.03)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: ScreenSize.height * 0.066)
                    
                    SettingListView()
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: ScreenSize.height * 0.03, leading: ScreenSize.width * 0.13, bottom: ScreenSize.height * 0.06, trailing: ScreenSize .width * 0.05))
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.7)
                .offset(y: ScreenSize.height * 0.06)
            }
            .padding(.top, ScreenSize.height * 0.01)
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
            VStack(alignment: .leading, spacing: ScreenSize.height * 0.012){
                Section(header:
                            Text(section.rawValue)
                    .font(.caption)
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
                        print("button cliked")
                    }){
                        Text(setting.content)
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}


