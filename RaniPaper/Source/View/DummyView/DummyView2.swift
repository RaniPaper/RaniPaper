//
//  DummyView2.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/26.
//

import SwiftUI

struct DummyView2: View {
    var body: some View {
        ZStack{
            Color.blue
            Button(action:{
                print("clicked")
            }){
                Text("Dummy View 2")
            }.foregroundColor(.white)
        }.ignoresSafeArea()
    }
}

struct DummyView2_Previews: PreviewProvider {
    static var previews: some View {
        DummyView2()
    }
}
