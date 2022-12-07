//
//  CustomDatePicker.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

struct CustomDatePicker: View {
    @ObservedObject var viewModel: CalendarViewModel
    @State var currentMonth: Int = 0
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            Color.white
            VStack(spacing:35){
                
                let days:[String] = ["일","월","화","수","목","금","토"]
                let calendarBg = Color(hexcode: "F4EDDB")
                
                // MARK: 년 월 죄우 버튼
                VStack {
                    let buttonColor = Color(hexcode: "D6B5A3")
                    Text(extraData()[0])
                        .font(.efDiary(20))
                    .fontWeight(.semibold)
                    HStack(spacing:20){
                        Spacer()
                        Button {
                                currentMonth -= 1
                            
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .font(.title2)
                                .foregroundColor(buttonColor)
                        }
                    
                            
                        Text(extraData()[1])
                            .font(.efDiary(30))
                        
                            
         
                            Button {
                          
                                    currentMonth += 1
                                
                            } label: {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .font(.title2)
                                    .foregroundColor(buttonColor)
                            }
                        Spacer()
                        
                    }
                }
                .padding(.horizontal)
           
                
                HStack(spacing:0)
                {
                    ForEach(days,id:\.self){ day in
                        
                        Text(day)
                            .font(.efDiary(18))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(day == "일" ? .red : .black)
                    }
                }
                
                // Dates...
                // Lazy Grid..
                
                LazyVGrid(columns: columns,spacing:15) {
                    ForEach(extractDate()){ value in
                        CardView(value: value)
                            .background(
                                Capsule().fill(.pink)
                                    .padding(.horizontal,8)
                                    .opacity(value.date.isSameDay(with: viewModel.currentDate) ? 1 : 0)
                            )
                            .onTapGesture {
                                withAnimation {
                                    viewModel.currentDate = value.date
                                }
                                
                            }
                    }
                }
                
            }
            .onChange(of: currentMonth) { newValue in
                //udapteMonth
                
                viewModel.currentDate = getCurrentMonth()
        }
        }
        //VStack
    }
    
    
    
    @ViewBuilder
    func CardView(value: DateModel)->some View{
        
        let calendar = Calendar.current
        let lastMonth = calendar.date(byAdding: .month, value:-1 , to: viewModel.currentDate)!
        //이전 달 ,현재 Date에서 Month -1.
        
        
    
        let lastMonthRange = calendar.range(of: .day, in: .month, for: lastMonth)! //해당하는 달의 날짜가 몇일까지 있는지
        
        let dayOfLastMonth = lastMonthRange.last!
    
        
        VStack{
            
            // 음수 와 0은 이전 달 이므로, 이전달 마지막 일부터 + (-거리)해준다
            
            if value.day != -1 {
                // 모든 tasks 중 선택한 날짜의 tasks가 있으면
                if !viewModel.tasks.filter({ value.date.isSameDay(with: $0.deadLine) }).isEmpty {
                    
                    //현재 선택한 날짜와 cardView 날짜가 같으면
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(value.date.isSameDay(with: viewModel.currentDate) ? .white : .black)
                        .frame(maxWidth:.infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(value.date.isSameDay(with: viewModel.currentDate) ? .white : .pink)
                        .frame(width:8,height: 8)
                }
                else { //만약 현재 날짜에 테스크가 없다면
                    Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(value.date.isSameDay(with: viewModel.currentDate) ? .white : .black)
                    .frame(maxWidth:.infinity)
                    
                    Spacer()
                }
                
                
            }
        }
        .padding(.vertical,8)
        .frame(height:60,alignment: .top)
        
    }
    
    
    //화면에 보여주기 위해 Year과 Month 추출하기
    func extraData() ->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM" // MM:숫자 , MMM:월 줄임단어, MMMM:월 풀네임
        
        let date = formatter.string(from: viewModel.currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    
    
    //현재 날짜의 월 얻기
    func getCurrentMonth() ->Date{
        let calendar = Calendar.current
        print("current")
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else
        {
            return Date()
        }
        
        return currentMonth
    }
    
    
    func extractDate() -> [DateModel] {
        let calendar = Calendar.current
        
        var days = viewModel.currentDate.getAllDates().compactMap { date -> DateModel in
            let day = calendar.component(.day, from: date)
            
            return DateModel(day: day, date: date)
        }
        
        //정확한 주를 추출하기 위한 offset 추가
        
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        //해당 날짜의 첫번째 주 평일을 갖고 온다
        
        for _ in 0..<firstWeekDay-1 {
            days.insert(DateModel(day: -1, date: Date()),at:0)
        } //부족한 갯수만큼 -1을 넣어줌
        
        return days
        
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
