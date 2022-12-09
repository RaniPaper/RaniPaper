//
//  TestGalleryView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/09.
//

import SwiftUI

struct TestGalleryView: View {
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 1

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                Image("gallery_full").resizable().scaledToFit()
                    .scaleEffect(currentAmount + lastAmount)

            }
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        // 기본사이즈보다 작아지지 않도록
                        if (currentAmount + lastAmount >= 1) { currentAmount = value - 1 }
                    }
                    .onEnded { value in
                        lastAmount += currentAmount
                        currentAmount = 0
                        // 기본사이즈보다 작아지지 않도록
                        if lastAmount < 1 { withAnimation(.spring()) { lastAmount = 1 } }
                    }
            )

        }.background(Color(hexcode: "f1edcb"))
        
    }
}

struct TestGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        TestGalleryView()
    }
}
