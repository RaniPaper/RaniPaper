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
    @StateObject var viewModel = HomeViewModel()
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Image("mainTmp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isAnimating = true
                    }
                    
                }
            
            fileManagerTestButtonView() // 테스트용입니다.
            
            Button{
                MySoundSetting.instance.playSound()
            } label: {
                Text("play music")
            }
            
            if isAnimating {
                LottieView(name: "mail-boxletter-box", loopMode: .playOnce)
                    .background(Color.black.opacity(0.6))
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isAnimating = false
                        }
                    }

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
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
}
