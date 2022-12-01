//
//  StickerView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

struct StickerView: View {
    
    var memo:MemoModel
    
    var body: some View {
        Image("sticker")
            .overlay() {
                VStack{
                    Text(memo.title)
                        .font(.beomsuk(20))
                        .lineLimit(1)
                    Divider()
                    Text(memo.content).lineLimit(2).frame(maxWidth:.infinity,alignment: .leading)
                        .font(.samanco(15))
                }
                .padding()
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            }
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView(memo: MemoModel(title: "1234", content: "125521512"))
    }
}
