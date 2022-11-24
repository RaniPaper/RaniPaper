//
//  LockView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI
import Combine

struct LockView: View {
    @Binding var lockState:LockState
    @ObservedObject var viewModel = LockViewModel()
    
    
    var body: some View {
        VStack{
            
            
        }
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView(lockState: .constant(.locked))
    }
}
