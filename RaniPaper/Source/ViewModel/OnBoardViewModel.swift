//
//  OnBoardViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/20.
//

import Foundation

final class OnBoardViewModel: ObservableObject{
    @Published var onBoardModels: [OnBoardModel]
    
    init(){
        print("✅ OnBoardViewModel 생성")
        
        onBoardModels = [
            OnBoardModel(title: "안녕하세요!",
                         contents: ["지금부터 라니페이퍼의 간단한 사용법을 가르쳐드릴게요!", "계속하시려면 옆으로 당겨주세요"],
                         view: .home,
                         images: "onBoardHome"),
            OnBoardModel(title: "여기는 메인화면이에요",
                         contents: ["메인화면은 시간에 따라 하늘이 바뀌어요", "화면 오른쪽 끝을 옆으로 당기면 메뉴가 열려요", "", "(x를 눌러 설명을 닫을 수 있어요)"],
                         view: .home,
                         images: "onBoardMain",
                         page: 2),
            OnBoardModel(title: "여기는 다이어리 화면이에요",
                         contents: ["위에는 달력이 있고", "아래로 스크롤을 내리면", "오늘의 할 일 목록을 확인할 수 있어요", "", "    화살표를 눌러서 달을 변경할 수 있어요!"],
                         view: .diary,
                         images: "onBoardDiary"),
            OnBoardModel(title: "+ 버튼을 누르면 할 일 목록을 작성할 수 있어요",
                         contents: ["할 일이 없을 때는", "귀여운 비챤님이", "한마디씩 남겨주신답니다!"],
                         view: .diary,
                         images: "OnBoardDiary2",
                         page: 2),
//            OnBoardModel(title: "여기는 일정 화면이에요",
//                         contents: ["날짜, 시간, 내용, 티켓을 이용해", "오늘의 일정과 알람을 설정할 수 있어요."],
//                         view: .diary,
//                         images: nil),
//            OnBoardModel(title: "일정을 작성하면 이런 모양이에요",
//                         contents: ["원하는 색깔, 티켓으로 할 일 목록을 꾸며볼까요?"],
//                         view: .diary,
//                         images: nil),
            OnBoardModel(title: "여기는 기록화면이에요",
                         contents: ["메모를 적으면 여기에 표시돼요", "", "크게보기/작게보기 버튼으로", "목록을 보기 편하게 고를 수 있어요"],
                         view: .memo,
                         images: "OnBoardMemo"),
            OnBoardModel(title: "여기는 기록화면이에요",
                         contents: ["지우고 싶은 메모가 있나요?", "", "메모를 꾹 누르고있으면 체크박스가 생겨요"],
                         view: .memo,
                         images: "OnBoardMemo2",
                        page: 2),
            
            OnBoardModel(title: "여기는 기록화면이에요",
                         contents: ["지우고 싶은 메모를 체크한 뒤", "", "삭제 버튼을 누르면 체크한 메모를 삭제할 수 있어요"],
                         view: .memo,
                         images: "OnBoardMemo3",
                        page: 3),
            
            OnBoardModel(title: "여기는 메모 작성 화면이에요",
                         contents: ["제목과 내용을 적은 뒤", "    버튼으로 저장할 수 있어요"],
                         view: .memo,
                         images: "OnBoardMemo4",
                         page: 4),
            OnBoardModel(title: "도장을 누르면 다른 모양으로 바꿀 수 있어요",
                         contents: ["오늘의 기분을 표현해보는건 어떨까요?"],
                         view: .memo,
                         images: "OnBoardMemo5",
                         page: 5),
            
            OnBoardModel(title: "여기는 설정 화면이에요",
                         contents: ["배경음이나 효과음, 알람등", "앱 내부 효과를 끌 수 있어요", "", "오류를 발견하시면 언제든 문의해주세요!"],
                         view: .setting,
                         images: "onBoardSetting"),
        ]
    }
    
    deinit{
        print("❌ OnBoardViewModel 소멸")
    }
}
