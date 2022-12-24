//
//  GalleryView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/08.
//

import SwiftUI
import AlertToast

struct GalleryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = GalleryViewModel()
    @State private var selectedRollingPaper: RollingPaper? = nil
    @State private var showToast = false
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()
                .frame(height: 40)
            
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
        }
        .fullScreenCover(item: $selectedRollingPaper) { rollingPaper in
            RollingPaperDetailView(rollingPaper: rollingPaper)
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .complete(.green), title: "클립보드에 시크릿코드를 복사했어요!")
        }
        
    }
    
    private func CustomNavigationBar() -> some View {
        HStack {
            Button { dismiss() } label: {
                Image("arrow_left_mailbox")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }
            
            Spacer()
            
            Button {
                UIPasteboard.general.string = "happy birthday to you!"
                HapticManager.shared.notification(success: true)
                showToast.toggle()
            } label: {
                Image("black_board")
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .overlay {
                        Text(viewModel.isAllUnlocked ? "시크릿 코드" : "잠김")
                            .font(.efDiary(10))
                            .kerning(-0.7)
                            .foregroundColor(.white)
                    }
            }
            .disabled(!viewModel.isAllUnlocked)
        }
    }
    
    private func BlackBoardView() -> some View {
        HStack(spacing: 0) {
            Image("gallery_first").resizable().scaledToFit()
            
            ForEach((1...17), id: \.self) { _ in
                Image("gallery_n").resizable().scaledToFit()
            }
            
            Image("gallery_last").resizable().scaledToFit()
        }
    }
    
}

fileprivate struct GalleryRollingPaperView: View {
    let rollingPaper: RollingPaper
    private var messageSize: CGSize
    private var messageOffset: CGSize = .init(width: 0, height: 0)
    
    init(rollingPaper: RollingPaper) {
        self.rollingPaper = rollingPaper

        switch rollingPaper.backgroundImage {
        case "paper_rectangle":
            messageSize = .init(width: 100, height: 100)
        case "paper_butterfly":
            messageSize = .init(width: 95, height: 95)
        case "paper_heart":
            messageSize = .init(width: 80, height: 80)
            messageOffset = .init(width: 0, height: -9)
        case "paper_flower":
            messageSize = .init(width: 80, height: 80)
        default:
            messageSize = .init(width: 75, height: 75)
        }
    }
    
    var body: some View {
        Image(rollingPaper.backgroundImage).resizable()
            .frame(width: 125, height: 125)
            .overlay {
                Image(rollingPaper.contentImage).resizable()
                    .frame(width: messageSize.width, height: messageSize.height)
                    .offset(messageOffset)
                    //.background { Color.white }
            }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
        
        GalleryView().previewDevice("iPhone 8")
    }
}
