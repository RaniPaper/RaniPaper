//
//  MenuViewModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/24.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var menuList: [String] = ["오늘의 할 일"
                                         , "단어 검색"
                                         , "다이어리 꾸미기"
                                         , "설정"
                                         , "크레딧"]
    @Published var Offset: CGFloat = Menu.minOffset
    @Published var isOpen: Bool = false
}
