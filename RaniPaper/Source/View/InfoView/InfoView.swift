//
//  InfoView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
// Info View For Test

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack{
            Text("'라니 페이퍼'입니다")
        }
        .ignoresSafeArea()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
