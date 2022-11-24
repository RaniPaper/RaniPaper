//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation

final class MenuViewModel: ObservableObject {
    @Published var menuList: [String] = ["오늘의 할 일", "단어 검색", "다이어리 꾸미기", "설정", "크레딧"]
    //menu에 들어갈 항목들, menu model 구현 후 model 내부의 key들로 변경 예정
    
}
