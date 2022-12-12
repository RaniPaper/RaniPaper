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
            VStack{
                Form{
                    Section(header: Text("")){
                        HStack{
                            Image("viic1")
                            VStack(alignment: .leading){
                                Text("비챤 님")
                                    .bold()
                                Text("모시깽 모시깽")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("소리")){
                        ForEach($viewModel.soundSettingList){ $setting in
                            Toggle(setting.key, isOn: $setting.isOn)
                        }
                        //                    .background(Color.clear)
                        //                    .listRowBackground(Color.clear)
                    }
                    
                    ForEach(SettingModel.Section.allCases, id: \.self){ section in
                        Section(header: Text(section.rawValue)){
                            ForEach(viewModel.settingList){ setting in
                                if setting.section.rawValue == section.rawValue {
                                    Button(action: {
                                        
                                    }){
                                        Text(setting.content)
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
//                .listStyle(.plain)
//                .padding(.horizontal, 20)
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
        }
        .ignoresSafeArea()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(UserState.shared)
    }
}
