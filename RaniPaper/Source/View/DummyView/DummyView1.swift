//
//  DummyView1.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/26.
//

import SwiftUI

struct DummyView1: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.red
                Button(action:{
                    
                }){
                    Text("Dummy View 1")
                }.foregroundColor(.white)
            }.ignoresSafeArea()
        }
    }
}

struct DummyView1_Previews: PreviewProvider {
    static var previews: some View {
        DummyView1()
    }
}
