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
    @State var rollingPaper: String?
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                
                // MARK: LottieView
                if isAnimating { // 애니메이션 시작
                    
                    LottieView(name: "mail-boxletter-box", speed: 0.7) {
                        //애니메이션이 너무 빨리 끝나서 0.5초 딜레이
                        isAnimating = false
                        
                        //남은 롤링페이퍼가 있을 경우에만 보여줌
                        rollingPaper = viewModel.rollingPapers.popFirst()
                        if rollingPaper != nil { shouldShowRollingPaper = true }
                     
                    }
                    .background(Color.black.opacity(0.6))
                    
                } else { // 애니메이션 시작 전
                    
                    if !viewModel.rollingPapers.isEmpty {
                        Image("mail_box_temp")
                            .resizable()
                            .scaledToFit()
                        
                            .onTapGesture {
                                withAnimation { isAnimating = true }
                            }
                    } else { // 남은 롤링페이퍼가 없는 경우
                        RollingPaperEmptyView()
                    }
                    
                }
            }
            
            // MARK: 오른쪽 아래 뒤로가기 버튼
            DismissButton()
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

        }
        .fullScreenCover(isPresented: $shouldShowRollingPaper) {
            RollingPaperView(rollingPaper: rollingPaper!)
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
