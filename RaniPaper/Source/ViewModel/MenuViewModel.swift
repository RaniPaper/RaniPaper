//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation

final class MenuViewModel: ObservableObject {
    @Published var menuList: [String] = ["menu1", "menu2", "menu3"]
    //menu에 들어갈 항목들, menu model 구현 후 model 내부의 key들로 변경 예정
    
}
