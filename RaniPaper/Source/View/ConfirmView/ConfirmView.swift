//
//  ConfirmView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/24.
//

import SwiftUI
import PopupView


struct ConfirmView: View {
    @EnvironmentObject var userState: UserState
    @State var showLockView: Bool = false
    let textSize: CGFloat = 27
    
    var body: some View {
        ZStack{
            Image("startBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(spacing:30){
                Text("나는..")
                    .font(.efDiary(30))
                    .foregroundColor(.black)
                
                HStack(spacing:30){
                    VStack{
                        Button {
                                withAnimation {
                                    showLockView.toggle()
                                }
                            
                        } label: {
                            CircleImage(source: "viichan",color:Color.green1)
                            
                        }
                        Text("비챤")
                            .font(.efDiary(textSize))
                            .foregroundColor(.black)
                    }
                    VStack{
                        Button {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                withAnimation {
                                    userState.update(.fan)
                                }
                            }
                        } label: {
                            CircleImage(source: "leaves",color:Color.lightBrown)
                            
                        }
                        Text("이파리")
                            .font(.efDiary(textSize))
                            .foregroundColor(.black)
                    }
                   
                    
                    
                }
                
            }
        }.popup(isPresented: $showLockView,closeOnTap: false,closeOnTapOutside: true,backgroundColor: .black.opacity(0.2)) {
            
            LockView(showLockView:$showLockView).environmentObject(userState)
        }
        .edgesIgnoringSafeArea(.vertical)
    

    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView().environmentObject(UserState.shared)
    }
}

struct CircleImage: View {
    let source:String
    let color:Color
    
    var body: some View {

            Image(source)
                .resizable()
                .aspectRatio(contentMode: .fill)
        .frame(width:ScreenSize.width/4,height: ScreenSize.width/4).zIndex(1)
    }
}
