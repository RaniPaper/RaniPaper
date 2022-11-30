//
//  CalendarView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI
import PopupView
struct CalendarView: View {
    
    @StateObject var viewModel = CalendarViewModel()
    var body: some View {
        
        ZStack(alignment:.bottom) {
            ScrollView(.vertical,showsIndicators: false)
            {
                VStack(spacing: 20) {
                    
                    CustomDatePicker(currentDate: $viewModel.currentDate)
                }
                .padding(.vertical)
            }
            
            Spacer(minLength: 20)
            HStack {
                           
                           Spacer()
                           
                           Button(action: {
                               //Place your action here
                               viewModel.showEdit = true
                           }) {
                               Image("Floating")
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(width: 70, height: 70)
                                   .padding(.bottom,10)
                                   .padding(.trailing,10)
                           }
                           
                           
            }
            //HStack
            
        }
        .popup(isPresented: $viewModel.showEdit,closeOnTap: false,closeOnTapOutside: false,backgroundColor: .white) {

            EditTaskView(showEdit: $viewModel.showEdit)
        }
        
        
       
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
