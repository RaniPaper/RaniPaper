//
//  HomeView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/29.
//

import SwiftUI
import UIKit
import Lottie

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Image("mainTmp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isAnimating = true
                    }
                    
                }
            
            if isAnimating {
                LottieView(name: "mail-boxletter-box", loopMode: .playOnce)
                    .background(Color.black.opacity(0.6))
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .opacity))
                    //.transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation {
                            isAnimating = false
                        }
                    }
                    
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
