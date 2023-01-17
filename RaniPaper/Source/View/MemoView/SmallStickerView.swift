//
//  StickerView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

struct SmallStickerView: View {
    
    var memo:MemoModel
    

    
    var body: some View {
        let width = ScreenSize.width / 1.2
        Image("smallSticker")
            .resizable()
            .frame(maxWidth:width,maxHeight: (width*2)/11)
            .scaledToFit()
            .overlay() {
                VStack{
                    Text(memo.title)
                        .font(.beomsuk(20))
                        .lineLimit(1)
                        .padding(.leading,20)
                }
                .padding()
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            }
    }
}

struct SmallStickerView_Previews: PreviewProvider {
    static var previews: some View {
        SmallStickerView(memo: MemoModel(title: "1234", content: "125521512",stamp: 0))
    }
}
