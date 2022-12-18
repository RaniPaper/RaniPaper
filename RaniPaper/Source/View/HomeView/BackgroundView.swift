//
//  BackgroundView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/18.
//

import SwiftUI

struct BackgroundView: View {
    @StateObject var viewModel = HomeViewModel()
    //테스트용 변수들
    @State var testTime = Date()
    @State var isTest = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            ZStack{
                Image("main_\(viewModel.backgroundTime.rawValue)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0), value: viewModel.backgroundTime)
                
                Image("main_over")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .overlay{
                switch viewModel.backgroundTime{
                case .moring:
                    Color.blue.opacity(0.07)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.backgroundTime)
                case .night:
                    Color.black.opacity(0.1)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.backgroundTime)
                case .sunset:
                    Color.red.opacity(0.08)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.backgroundTime)
                default:
                    EmptyView()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.backgroundTime)
                }
            }
            .onReceive(timer){ input in
                var time = input
                if isTest{
                    time = testTime
                }
                viewModel.backgroundTime = viewModel.getCurrentTime(input: time)
                    
            }
            
            TimeTestButtonView()
        }
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

extension BackgroundView{    
    private func TimeTestButtonView() -> some View{
        VStack{
            Button(action:{
                isTest = !isTest
            }){
                if !isTest{
                    Text("Real Time Mode")
                        .foregroundColor(.red)
                } else{
                    Text("Time Test Mode")
                        .foregroundColor(.red)
                }
            }
            ForEach(HomeViewModel.BackgroundTime.allCases, id: \.self){ time in
                Button(action:{
                    withAnimation{
                        switch time{
                        case .moring:
                            testTime = Calendar.current.date(from: DateComponents(hour: 7)) ?? Date()
                        case .noon:
                            testTime = Calendar.current.date(from: DateComponents(hour: 11)) ?? Date()
                        case .sunset:
                            testTime = Calendar.current.date(from: DateComponents(hour: 16)) ?? Date()
                        case .night:
                            testTime = Calendar.current.date(from: DateComponents(hour: 20)) ?? Date()
                        }
                    }
                }){
                    Text(time.rawValue)
                }
            }
            Text("현재 시간: \(isTest ? testTime : Date())")
        }
        .padding(.bottom, 500)
    }
}
