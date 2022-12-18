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
    let size: CGSize
    
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
                    .overlay {
                        Image(rollingPaper.contentImage)
                            .resizable()
                            .frame(width: size.width, height: size.height)
                            .background { Color.white }
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
        RollingPaperView(rollingPaper: RollingPaper(contentImage: "rolling_paper_29", backgroundImage: "paper_flower"), size: CGSize(width: 220, height: 220))
        RollingPaperView(rollingPaper: RollingPaper(contentImage: "rolling_paper_29", backgroundImage: "paper_flower"), size: CGSize(width: 220, height: 220)).previewDevice("iPhone 8")
    }
}
