//
//  RollingPaperView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/02.
//

import SwiftUI

struct RollingPaperView: View {
    @Environment(\.dismiss) private var dismiss
    let rollingPaper: RollingPaper
    private let messageRatio: CGFloat
    @State private var messageOffset: CGSize = .init(width: 0, height: 0)
    
    init(rollingPaper: RollingPaper) {
        self.rollingPaper = rollingPaper
        
        switch rollingPaper.backgroundImage {
        case "paper_rectangle":
            messageRatio = 0.9
        case "paper_butterfly":
            messageRatio = 0.8
        case "paper_heart":
            messageRatio = 0.6
            messageOffset = .init(width: 0, height: -20)
        case "paper_flower":
            messageRatio = 0.6
        default:
            messageRatio = 0.6
        }
    }
    
    var body: some View {
        ZStack {
            Image("mail_box_ready")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 30)
            
            VStack {
                HStack {
                    DismissButton()
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                
                Spacer()
                
                Image(rollingPaper.backgroundImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1),contentMode: .fit)
                    .frame(width: ScreenSize.width)
                    .overlay {
                        Image(rollingPaper.contentImage)
                            .resizable()
                            .aspectRatio(CGSize(width: 1, height: 1),contentMode: .fit)
                            .frame(width: ScreenSize.width * messageRatio)
                            //.background { Color.white }
                            .offset(messageOffset)
                    }
                
                Spacer()
            }
            
        }
    }
    
    private func DismissButton() -> some View {
        Button { dismiss() } label: {
            Image(systemName: "xmark")
                .font(.title).foregroundColor(.white)
        }
    }
}

struct RollingPaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingPaperView(rollingPaper: RollingPaper(contentImage: "rolling_paper_29", backgroundImage: "paper_flower"))
        RollingPaperView(rollingPaper: RollingPaper(contentImage: "rolling_paper_29", backgroundImage: "paper_flower")).previewDevice("iPhone 8")
    }
}
