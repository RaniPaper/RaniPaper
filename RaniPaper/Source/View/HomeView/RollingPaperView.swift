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
            Color.black.opacity(0.9).ignoresSafeArea()
            
            VStack {
                HStack {
                    DismissButton()
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                
                Spacer()
                
                Image(rollingPaper.contentImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1),contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .padding(80)
                    .background {
                        Image(rollingPaper.backgroundImage)
                            .resizable()
                            .scaledToFit()
                    }
                
                Spacer()
            }
            
        }
    }
    
    func DismissButton() -> some View {
        Button { dismiss() } label: {
            Image(systemName: "xmark")
                .font(.title).foregroundColor(.white)
        }
    }
}

struct RollingPaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingPaperView(rollingPaper: RollingPaper(contentImage: "rolling_paper_3", backgroundImage: "paper_heart"), size: CGSize(width: 200, height: 200))
    }
}
