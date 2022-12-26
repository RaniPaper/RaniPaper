<br/>

# 라니 페이퍼 <img width="100" alt="mac512" align = left src="https://user-images.githubusercontent.com/60254939/209456906-e6b5ed18-acab-4d2f-8dcc-9f9e319e2f7c.png">



<br><br>
<div align="center">

<img width="1512" alt="image" src ="https://user-images.githubusercontent.com/60254939/209528072-242f1317-04ba-485e-a17a-1b2c4332880f.png" />

<br><br>
<b>개발 기간: 2022.11.20 ~ 2022.12.25 (약 1개월)</b>

<br><br>
[<img width="220" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://user-images.githubusercontent.com/55099365/196023806-5eb7be0f-c7cf-4661-bb39-35a15146c33a.png">](https://apps.apple.com/kr/app/id1660706595)
 
 
 
</div>


<div align = "left">

### 🛠 Development Environment

![Generic badge](https://img.shields.io/badge/iOS-15.0+-lightgrey.svg) ![Generic badge](https://img.shields.io/badge/Xcode-14.0.1-blue.svg)

<br/>

### ✨ Skills & Tech Stack
* SwiftUI
* Combine
* Lottie
* AlertToast
* PopView
* Github
* Discord
<br/>

### 🔀 Git branch & Git Flow

- master(defulat)

- develop(개발)

- feature
  - feature/onboard
  - feature/side_menu_enable
  - feature/mailbox_sound
  
  ...

- hotfix
  - hotfix/setting_animation
  - hotfix/on_board_resource
  
  ...
  

<br>

### 🗂 Folder Structure
```shell
RaniPaper
│
├── Audio
│
├── Fonts
│ 
├── Resource
│   ├── Enum.swift
│
│ 
└── Source
    ├── Extension
    ├── Model
    ├── Utlis
    ├── View
    └── ViewModel
```
<br><br>
### 🧑‍💻 Authors

<div align="center"> 
  
| [Hamp](https://github.com/yongbeomkwak) | [케이](https://github.com/youn9k) | [굵은소금](https://github.com/JiDongseok11) | 
|:---:|:---:|:---:|
|<img width="120" alt="알로라" src="https://avatars.githubusercontent.com/u/48616183?v=4">|<img width="120" alt="케이" src="https://avatars.githubusercontent.com/u/60254939?v=4">|<img width="120" alt="굵은소금" src="https://avatars.githubusercontent.com/u/79965837?v=4">

  
</div>


 
 ### 🔥 기술적 도전
<details>
<summary>  Path를 이용한 점선찍기 </summary>

#### Line Struct 구현
```swift 
 struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
 
 ```
 
#### 적용 
 
```swift 
Line()
 .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
 .foregroundColor(Color.memoPrimary)
 .frame(height: 1).padding(.horizontal,15)
 .padding(.top,3)
 
 ```
</details>
 
 <details>
<summary>  키보드 옵저빙 및 스크롤 연동 </summary>

#### Combine을 이용한 키보드 옵저빙
```swift 
private var subscription = Set<AnyCancellable>()
    
    private let keyboardWillShow =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { output in
            (output.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            // 유저 정보 맵에서 keyboard 높이를 얻는다.
        }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero}
    
    
    
    init(){
        print("✅ EditTaskViewModel 생성")
        Publishers.Merge(keyboardWillShow, keyboardWillHide)
                .subscribe(on: DispatchQueue.main) // UI 변화 이므로 메인. 쓰레
                .sink(receiveValue: { [weak self] keyboardHeight in
                    guard let self = self else { return }
                    self.keyboardHeight = keyboardHeight
                })
                .store(in: &subscription)
                  // .assign(to: \.keyboardHeight, on:  self)
    }
 ```
 
#### ScrollViewReader를 이용한 키보드 팝업 시 스크롤 이동
 
```swift 
  
@Namespace var bottom //keyboard 올라올 때 사용할 bottom 버튼 ID
//스크롤 뷰 리더로 덮음   
ScrollViewReader { scrollProxy in
                  ScrollView {
                   ...생략
  
                    해당뷰.id(bottom) // 아이디 설정
                   }
  
  
                  .onChange(of: viewModel.keyboardHeight, perform: { v in
                            if(v>0)
                            {
                                //키보드가 나올 때 바텀 버튼으로 스크롤, center 까지
                                withAnimation {
                                    scrollProxy.scrollTo(bottom, anchor: .center)
                                }
                            }
                            
                        })
                
                 }
 
 ```
</details>

<details>
<summary> 데이트(Date) 관련 정리  </summary>
 
1. DateComponet,calendar.date,range
```swift
 let range2 = calendar.range(of: .day, in: .month, for: tmpDate)! //해당하는 달의 날짜가 몇일까지 있는지
    
    print(components)
    // year: 2022 month: 12 day: 28 isLeapMonth: false  ,윤년이 아닌 2022년 12월 28
    print(tmpDate)
    // 2022-12-27 15:00:00 +0000 , 이거는 UTC +0 과 +9 차이
    print(range2)
    // 1..<32  (1~31) 12월 31일까지 있음
```
              
2. ByAdding
```swift
calendar.date(byAdding: 어떤날짜 단위를?, value: Int값 , to: Date객체)

to값에 value를 더한다 그 때 byAdding단위에 더한다

let tmp = calendar.date(byAdding: .year, value: 5 , to: tmpDate)!

tmpDate = 2022-12-27 15:00:00 +0000 이고 
단위가 year, value가 5이기 때문에
tmp 값은 
2027-12-27 15:00:00 +0000이 된다 , 2022+5 = 2027
```
3. DateComponents 추출
```swift
func component(_ component: Calendar.Component, from date: Date) -> Int


calendar.component(.day, from: date) Date객체인 date으로 부터 .day속성을 추출
```
 
4. SameDate ?
```swift
func isSameDate(date1: Date, date2: Date)-> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
```
      
</details>

<details>
<summary> Date to String  </summary>

1. Date날짜 문자열로 변환
```swift
            Text(Date().formatted(date: .abbreviated, time: .standard)) 
// Jun 28, 2022, 7:18:59 PM
            Text(Date().formatted(date: .numeric, time: .omitted))  
// 6/28/2022
            Text(Date().formatted(date: .omitted, time: .shortened))    
// 7:18 PM
            Text(Date().formatted(date: .long, time: .complete))    
// June 28, 2022, 7:18:59 PM GMT+9
            Text(Date().formatted(date: .complete, time: .complete))    
// Tuesday, June 28, 2022, 7:18:59 PM GMT+9
            Text(Date().formatted())    
// 6/28/2022, 7:18 PM            
  
date

.complete : Tuesday, June 28, 2022 (요일, 날짜, 년도 순)
.long : June 28, 2022 (.complete에서 요일만 없어짐)
.abbreviated : Jun 28, 2022 (월을 3글자로 줄인 후 날짜, 년도는 4자리)
.numeric : 6/28/2022 (월/일/년도 순)
.omitted : 생략

time

.complete : 7:18:59 PM GMT+9 (시:분:초 AM/PM 표준시)
.standard : 7:18:59 PM (표준시 표기 X)
.shortened : 7:18 PM (초 표기 X)
.omitted : 생략
```

2. DateFormatter를 이용한 String 전환
```swift
func extraData() ->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM" // MM:숫자 , MMM:월 줄임단어, MMMM:월 풀네임
        
        let date = formatter.string(from: viewModel.currentDate)
        
        return date.components(separatedBy: " ")
}
```

</details>




</div>
