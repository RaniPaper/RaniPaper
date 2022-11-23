//
//  LaunchVIew.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI

struct LaunchView: View {
    
    let title = "비챤님의 일상에 자그마한 행복을"
    
    var body: some View {
        ZStack{
            Color.white
            VStack{
    
                Image("Launch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                Text(title).font(.title2)
                
            }
           
            
            
        }.ignoresSafeArea()
    }
}

struct LaunchVIew_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
