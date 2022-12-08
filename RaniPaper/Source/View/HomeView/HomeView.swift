//
//  HomeView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import SwiftUI
import UIKit
import Lottie

struct HomeView: View {
    @EnvironmentObject var userState: UserState
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("main_static")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        Image("mail_box_static")
                        Circle().frame(width: 20).foregroundColor(.blue) // 이미지 중심
                        NavigationLink {
                            MailBoxAnimationView(viewModel: viewModel)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Rectangle().strokeBorder(lineWidth: 3) // 터치 범위
                                .frame(width:100, height: 180)
                                .contentShape(Rectangle())
                        }
                    })
                
                // MARK: 테스트용 뷰
                TestView()
                
            }
            .ignoresSafeArea()
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserState.shared)
    }
}

extension HomeView {
    func TestView() -> some View {
        VStack {
            Spacer()
            
            if userState.userType == .viichan {
                Text("계정상태: viiChan")
            } else { if userState.userType == .fan {
                Text("계정상태: fan")
            } else {
                Text("계정상태: none")
            } }
            Button {
                withAnimation { userState.update(.none) }
            } label: {
                Text("뒤로가기").foregroundColor(.red)
            }
            
            NavigationLink {
                hapticTestView()
            } label: {
                Text("햅틱테스트뷰 가기")
            }

           


            
            soundSettingTestButtonView()
            Spacer().frame(height: 50)
        }
    }
    
    func fileManagerTestButtonView() -> some View {
        VStack {
            Button {
                let result = MyFileManager.shared.create(at: .memo, fileName: "memo01.json", MemoModel(title: "테스트용 메모제목", content: "테스트용 내용입니다."))
                switch result {
                case .success():
                    print("success")
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            } label: {
                Text("CREATE").padding().background(RoundedRectangle(cornerRadius: 8).foregroundColor(.gray))
            }
            
            Button {
                let result = MyFileManager.shared.read(at: .memo, fileName: "memo01.json")
                switch result {
                case .success(let jsonData):
                    print(jsonData)
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            } label: {
                Text("READ").padding().background(RoundedRectangle(cornerRadius: 8).foregroundColor(.gray))
            }
            
            Button {
                let result = MyFileManager.shared.update(at: .memo, fileName: "memo01.json", MemoModel(title: "테스트용 메모제목2222", content: "테스트용 내용입니다.2222"))
                switch result {
                case .success():
                    print("success")
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            } label: {
                Text("UPDATE").padding().background(RoundedRectangle(cornerRadius: 8).foregroundColor(.gray))
            }
            
            Button {
                let result = MyFileManager.shared.delete(at: .memo, fileName: "memo01.json")
                switch result {
                case .success():
                    print("success")
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            } label: {
                Text("DELETE").padding().background(RoundedRectangle(cornerRadius: 8).foregroundColor(.gray))
            }
        }
    }
    
    func hapticTestView() -> some View{
        NavigationView {
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "iphone.radiowaves.left.and.right").foregroundColor(.orange)
                            Text("Notification type".uppercased())
                        }
                        .font(.title.bold())
                        Button("warning") { HapticManager.shared.notification(type: .warning) }
                        Button("error") { HapticManager.shared.notification(type: .error) }
                        Button("success") { HapticManager.shared.notification(type: .success) }
                        
                    
                        
                        Group { //stack이 10개가 넘어가기 때문에 group 적용
                            HStack {
                                Image(systemName: "iphone.radiowaves.left.and.right").foregroundColor(.orange)
                                Text("impact style".uppercased())
                            }
                                .font(.title.bold())
                            Button("heavy") { HapticManager.shared.impact(style: .heavy) }
                            Button("light") { HapticManager.shared.impact(style: .light) }
                            Button("medium") { HapticManager.shared.impact(style: .medium) }
                            Button("rigid") { HapticManager.shared.impact(style: .rigid) }
                            Button("soft") { HapticManager.shared.impact(style: .soft) }
                        }
                    }
                    .navigationBarTitle("햅틱 티스트 뷰")
                }
            
    }
}

//소리 테스트용
extension HomeView {
    func soundSettingTestButtonView() -> some View{
        VStack{
            Button(action:{
                MySoundSetting.SFX.play()
            }){
                Text("play SFX")
            }
            Button(action:{
                if MySoundSetting.Alarm.isPlaying(){
                    MySoundSetting.Alarm.stop()
                } else{
                    MySoundSetting.Alarm.play()
                }
            }){
                Text("play Alarm")
            }
        }
    }
}
