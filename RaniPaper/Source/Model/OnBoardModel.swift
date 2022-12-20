//
//  onBoardModel.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/20.
//

import Foundation

final class OnBoardModel: Identifiable{
    var id: UUID
    var title: String
    var contents: [String]
    var view: ViewSelection
    var images: String?
    
    init(title: String, contents: [String], view: ViewSelection, images: String?){
        id = UUID()
        self.title = title
        self.contents = contents
        self.view = view
        self.images = images
    }
}
