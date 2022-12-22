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
            ScrollView(.horizontal){
                ZStack{
                    TabView{
                        Color.red
                            .ignoresSafeArea()
                    }
                    .tabViewStyle(PageTabViewStyle())
                    Button(action:{
                        
                    }){
                        Text("Dummy View 1")
                    }.foregroundColor(.white)
                }
                .frame(width: ScreenSize.width)
            }.ignoresSafeArea()
        }
    }
}

struct DummyView1_Previews: PreviewProvider {
    static var previews: some View {
        DummyView1()
    }
}
