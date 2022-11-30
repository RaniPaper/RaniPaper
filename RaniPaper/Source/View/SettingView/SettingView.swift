//
//  SettingView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/01.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel = SettingViewModel()
    @State var toggle: Bool = true
    var body: some View {
        ZStack{
            Image("mainTmp")
                .resizable()
                .blur(radius: 5)
                .aspectRatio(contentMode: .fill)
            VStack{
                Image("viic1")
                
                List{
                    ForEach(viewModel.settingList, id: \.self){ setting in
                        Toggle(setting, isOn: $toggle)
                    }
                    .background(Color.clear)
                    .listRowBackground(Color.clear)
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
        SettingView()
    }
}
