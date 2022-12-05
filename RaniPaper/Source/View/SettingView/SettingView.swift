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
                Image("viic1")
                
                List{
                    ForEach($viewModel.settingList){ $setting in
                        Toggle(setting.key, isOn: $setting.isOn)
                    }
                    .background(Color.clear)
                    .listRowBackground(Color.clear)
                    
                    Button(action: {
                        withAnimation {
                            userState.update(.none)
                        }
                    }, label: { Text("로그아웃").foregroundColor(.red) })
                    
                }
                .listStyle(.plain)
                .padding(.horizontal, 20)
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
