//
//  RollingPaperView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/02.
//

import SwiftUI

struct RollingPaperView: View {
    @Environment(\.dismiss) private var dismiss
    let rollingPaper: String
    
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
                
                Image(rollingPaper)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
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
        RollingPaperView(rollingPaper: "rolling_paper_temp_2")
    }
}
