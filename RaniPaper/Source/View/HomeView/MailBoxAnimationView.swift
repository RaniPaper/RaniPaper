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
    @State private var isAnimating = false // lottie 애니메이션
    @State private var shouldShowRollingPaper = false // 롤링페이퍼
    @State private var rollingPaper: RollingPaper?
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
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
                                .onTapGesture {
                                    withAnimation { isAnimating = true }
                                }
                        } else { // 남은 롤링페이퍼가 없는 경우
                            RollingPaperEmptyView()
                                .onTapGesture {
                                    HapticManager.shared.impact(style: .heavy)
                                }
                        }
                        
                    }
                }
                .frame(width: ScreenSize.width, height: ScreenSize.height)
                
                // MARK: 뒤로가기 버튼 & 갤러리 이동 버튼
                    VStack {
                        Spacer()
                        HStack(alignment: .bottom) {
                            DismissButton()
                            Spacer()
                            GalleryButton()
                        }
                    }
                    .opacity(isAnimating ? 0 : 1)
                    .padding(.horizontal, 10)
                    .padding(.top, SafeAreaInsets.top)
                    .padding(.bottom, SafeAreaInsets.bottom + 30)
            }// ZStack
            .fullScreenCover(isPresented: $shouldShowRollingPaper) {
                RollingPaperDetailView(rollingPaper: rollingPaper!, background: {
                    Image("mail_box_ready")
                        .resizable()
                        .ignoresSafeArea()
                        .blur(radius: 30)
                })
                .onAppear {
                    HapticManager.shared.impact(style: .soft)
                }
            }.ignoresSafeArea()
            
        }
        
 
        
    }
    
    private func DismissButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image("arrow_left_yellow")
                .resizable()
                .frame(width: 75, height: 70)
        }
    }
    
    private func GalleryButton() -> some View {
        NavigationLink {
            GalleryView().navigationBarBackButtonHidden()
        } label: {
            Image("black_board")
                .overlay {
                    Text("\(viewModel.unLockPercent)% 해금")
                        .font(.efDiary(16))
                        .foregroundColor(.white)
                }
        }
    }
    
    private func RollingPaperEmptyView() -> some View {
        Image("mail_box_empty")
            .resizable()
            .frame(width: ScreenSize.width, height: ScreenSize.height)
    }
    
}


struct MailBoxAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MailBoxAnimationView(viewModel: HomeViewModel())
        //RollingPaperView(rollingPaper: "rolling_paper_temp_2")
    }
}
