//
//  CalendarView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date = Date()
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false)
        {
            VStack(spacing: 20) {
                
                CustomDatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
