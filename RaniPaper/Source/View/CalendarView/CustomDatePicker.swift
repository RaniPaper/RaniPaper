//
//  CustomDatePicker.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/28.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate:Date
    
    @State var currentMonth: Int = 0
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    var body: some View {
        
        VStack(spacing:35){
            
            let days:[String] = ["일","월","화","수","목","금","토"]
            
            HStack(spacing:20){
                VStack(alignment: .leading,spacing: 10) {
                    Text(extraData()[0])
                        .font(.caption2)
                        .fontWeight(.semibold)
                    
                    Text(extraData()[1])
                        .font(.title.bold())
                }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation {
                            currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    
                    Button {
                        withAnimation {
                            currentMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }

                
            }
            .padding(.horizontal)
            //Day View
            
            HStack(spacing:0)
            {
                ForEach(days,id:\.self){ day in
                    
                    Text(day)
                        .font(.callout)
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
                                .opacity(isSameDate(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            withAnimation {
                                currentDate = value.date
                            }
                            
                        }
                }
            }
            
            // - MARK: 테스크 카드
            VStack(spacing:15){
                Text("Tasks")
                    .font(.title2.bold())
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                
                if let task = tasks.first(where: { task in
                    return isSameDate(date1: task.taskDate, date2: currentDate)
                })
                {
                    ForEach(task.task){ task in
                        TaskCardView(task: task)
                        
                        
                    }
                }
                
                else
                {
                    Text("오늘은 할 일이 없어요")
                }
            }
            .padding(15)
            
        }
        .onChange(of: currentMonth) { newValue in
            //udapteMonth
            
            currentDate = getCurrentMonth()
        }
        //VStack
    }
    
    
    
    @ViewBuilder
    func CardView(value:DateModel)->some View{
        
        let calendar = Calendar.current
        let lastMonth = calendar.date(byAdding: .month, value:-1 , to: self.currentDate)!
        //이전 달 ,현재 Date에서 Month -1.
        
        
    
        let lastMonthRange = calendar.range(of: .day, in: .month, for: lastMonth)! //해당하는 달의 날짜가 몇일까지 있는지
        
        let dayOfLastMonth = lastMonthRange.last!
    
        
        VStack{
            
            // 음수 와 0은 이전 달 이므로, 이전달 마지막 일부터 + (-거리)해준다
            
            if value.day != -1 {
                if let task = tasks.first(where: { task in
                    return isSameDate(date1: task.taskDate, date2: value.date)
                })
                {
                    //만약 현재 날짜에 테스크가 존재하면
                    let d1 = task.taskDate
                    //Circle()이 존재
                    
                    //현재 선택한 날짜와 cardView 날짜가 같으면
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDate(date1:d1, date2: currentDate) ? .white : .black)
                        .frame(maxWidth:.infinity)
                    
                    Spacer()
                    Circle()
                        .fill(isSameDate(date1:d1, date2: currentDate) ? .white : .pink)
                        .frame(width:8,height: 8)
                }
                else
                {
            
                    //만약 현재 날짜에 테스크가 없다면
                    Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDate(date1:value.date, date2: currentDate) ? .white : .black)
                    .frame(maxWidth:.infinity)
                    Spacer()
                    
                }
                
                
                
                
                
            }
        }
        .padding(.vertical,8)
        .frame(height:60,alignment: .top)
        
    }
    
    
    //화면에 보여주기 위해 Year과 Month 추출하기
    
    func isSameDate(date1: Date, date2: Date)-> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraData() ->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
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
        
        var days = self.currentDate.getAllDates().compactMap { date -> DateModel in
            let day = calendar.component(.day, from: date)
            
            return DateModel(day: day, date: date)
        }
        
        //정확한 주를 추출하기 위한 offset 추가
        
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        //해당 날짜의 첫번째 주 평일을 갖고 온다
        
        for i in 0..<firstWeekDay-1 {
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
