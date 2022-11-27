//
//  MemoView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/27.
//

import SwiftUI

struct MemoView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true,content: {
                
            })
            
            .toolbar(content: {
                ToolbarItem(placement:.principal,content: {
                    VStack(spacing:10){
                        Text("기록(\(5)개)").font(.efDiary(25))
                        Divider()
                    }
                })
            })
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
