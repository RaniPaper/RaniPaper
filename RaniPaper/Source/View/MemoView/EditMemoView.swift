//
//  MemoEditView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI

struct EditMemoView: View {
    
    @Binding var showEditView:Bool
    
    var body: some View {
        VStack(spacing: 0){
            // - MARK: 타이틀 및 뒤로가기
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment:.leading){
                    Button {
                        UIApplication.shared.endEditing()
                        showEditView = false
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }.padding()
                    
                }
        }
    }
}

struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(showEditView: .constant(false))
    }
}
