//
//  AllOnBoardView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/22.
//

import SwiftUI

struct AllOnBoardView: View {
    @ObservedObject var viewModel = OnBoardViewModel()
    let radius = ScreenSize.width * 0.06
    
    var body: some View {
        ZStack{
            
        }
    }
}

struct AllOnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        AllOnBoardView()
    }
}

extension AllOnBoardView{
    func ExplainView() -> some View {
        Color.onBoardBackground
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(Color.onBoardBorder, lineWidth: 3))
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
    
    func OverlayView(model: OnBoardModel) -> some View{
        GeometryReader{ proxi in
            VStack(spacing: proxi.size.height * 0.01){
                Text("\(model.title)") //title
                    .font(.efDiary(17))
                    .frame(width: proxi.size.width)
                    .padding(.bottom, proxi.size.height * 0.02)
                ForEach(model.contents, id: \.self){ content in
                    Text("\(content)")
                        .font(.efDiary(14))
                        .frame(width: proxi.size.width)
                }
            }
            .fixedSize()
            .padding(.top, proxi.size.height * 0.03)
        }
    }
}
