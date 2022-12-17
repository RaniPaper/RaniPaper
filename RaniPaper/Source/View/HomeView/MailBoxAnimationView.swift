//
//  MailBoxAnimationView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/02.
//

import SwiftUI
import Lottie

struct MailBoxAnimationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: HomeViewModel
    @State var isAnimating = false // lottie 애니메이션
    @State var shouldShowRollingPaper = false // 롤링페이퍼
    @State var rollingPaper: RollingPaper?
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomLeading) {
                VStack {
                    
                    // MARK: LottieView
                    if isAnimating { // 애니메이션 시작
                        
                        LottieView(name: "mail-boxletter-box", speed: 0.7) {
                            isAnimating = false
                            
                            //남은 롤링페이퍼가 있을 경우에만 보여줌
                            rollingPaper = viewModel.randomRollingPaper()
                            if rollingPaper != nil { shouldShowRollingPaper = true }
                         
                        }
                        .background(Image("mail_box_ready").blur(radius: 50))
                        .transition(.opacity)
                        
                    } else { // 애니메이션 시작 전
                        
                        if ((MyUserDefaults.rollingPaperList?.isEmpty) != nil) {
                            Image("mail_box_ready")
                                .resizable()
                                .frame(width: ScreenSize.width, height: ScreenSize.height)
                                .onTapGesture {
                                    withAnimation { isAnimating = true }
                                }
                        } else { // 남은 롤링페이퍼가 없는 경우
                            RollingPaperEmptyView()
                        }
                        
                    }
                }
                
                // MARK: 뒤로가기 버튼 & 갤러리 이동 버튼
                    HStack {
                        DismissButton()
                        Spacer()
                        NavigationLink {
                            GalleryView()
                                //.navigationBarBackButtonHidden()
                        } label: {
                            Text("갤러리로 이동")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
            }// ZStack
            .fullScreenCover(isPresented: $shouldShowRollingPaper) {
                RollingPaperView(rollingPaper: rollingPaper!, size: CGSize(width: 200, height: 200))
            }.ignoresSafeArea()
            
        }
        
 
        
    }
    
    func DismissButton() -> some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .frame(width:50, height: 50)
                .foregroundColor(.gray)
                .overlay {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
        }
    }
    
    func RollingPaperEmptyView() -> some View {
        VStack {
            Spacer()
            Text("남은 롤링페이퍼가 없을 때 나오는 화면")
            Spacer()
        }
    }
    
}


struct MailBoxAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MailBoxAnimationView(viewModel: HomeViewModel())
        //RollingPaperView(rollingPaper: "rolling_paper_temp_2")
    }
}
