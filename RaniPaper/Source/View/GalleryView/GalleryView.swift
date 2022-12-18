//
//  GalleryView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/08.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel = GalleryViewModel()
    @State private var selectedRollingPaper: RollingPaper? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            ZStack {
                Color(hexcode: "052111") // 이미지 틈새 칠판색으로 메꾸기 위해
                
                BlackBoardView()
                
                Rectangle().foregroundColor(.yellow).opacity(0)
                    // 칠판 영역
                    .overlay(alignment: .topLeading) {
                        // 편지 부분
                        ForEach(viewModel.list) { rollingPaper in
                            GalleryRollingPaperView(rollingPaper: rollingPaper)
                                .offset(rollingPaper.position)
                                .onTapGesture { selectedRollingPaper = rollingPaper }
                        }
                    }
                    .padding(.vertical, 60)
                    .padding(.horizontal, 60)
            }
        }
        .fullScreenCover(item: $selectedRollingPaper) { rollingPaper in
            rollingPaperDetailView(rollingPaper)
        }
        
    }
    
    private func BlackBoardView() -> some View {
        HStack(spacing: 0) {
            Image("gallery_first").resizable().scaledToFit()
            
            ForEach((1...16), id: \.self) { _ in
                Image("gallery_n").resizable().scaledToFit()
            }
            
            Image("gallery_last").resizable().scaledToFit()
        }
    }
    
    private func rollingPaperDetailView(_ rollingPaper: RollingPaper) -> some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Button(action: { selectedRollingPaper = nil }){
                    Text("닫기 버튼")
                }
                Image(rollingPaper.backgroundImage).resizable().scaledToFit()
                    .overlay {
                        Image(rollingPaper.contentImage).resizable().padding(80)
                    }
            }
        }
    }
    
}

fileprivate struct GalleryRollingPaperView: View {
    let rollingPaper: RollingPaper
    var size: CGSize
    
    init(rollingPaper: RollingPaper) {
        self.rollingPaper = rollingPaper

        switch rollingPaper.backgroundImage {
        case "paper_rectangle":
            size = .init(width: 100, height: 100)
        case "paper_butterfly":
            size = .init(width: 95, height: 95)
        case "paper_heart":
            size = .init(width: 70, height: 70)
        case "paper_flower":
            size = .init(width: 70, height: 70)
        default:
            size = .init(width: 70, height: 70)
        }
    }
    
    var body: some View {
        Image(rollingPaper.backgroundImage).resizable()
            .frame(width: 125, height: 125)
            .overlay {
                Image(rollingPaper.contentImage).resizable()
                    .frame(width: size.width, height: size.height)
                    .background { Color.white }
            }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
        
        GalleryView().previewDevice("iPhone 8")
    }
}
