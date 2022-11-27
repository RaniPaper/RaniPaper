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
            VStack{
                Text("Hello")
            }
            
            .toolbar(content: {
                ToolbarItem(placement:.principal,content: {
                    Text("기록").font(.efDiary(30))
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
