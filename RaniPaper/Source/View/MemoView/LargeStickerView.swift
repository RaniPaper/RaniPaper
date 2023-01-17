//
//  StickerView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

struct LargeStickerView: View {
    
    
    var memo:MemoModel
 
    
    var body: some View {
        let width = ScreenSize.width / 2.5

        Image("largeSticker")
            .resizable()
            .frame(maxWidth:width,maxHeight: (width*36)/31)
            .scaledToFit()
            .overlay() {

                
                VStack{
                    
                    
                    Text(memo.title)
                        .font(.beomsuk(20))
                        .lineLimit(1)
                        .padding(.top,20)
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
        LargeStickerView(memo: MemoModel(title: "1234", content: "125521512",stamp: 0))
    }
}
