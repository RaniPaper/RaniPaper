//
//  GalleryView.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/08.
//

import SwiftUI

struct GalleryView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                Image("gallery_1").resizable().scaledToFit()
                Image("gallery_2").resizable().scaledToFit()
                Image("gallery_3").resizable().scaledToFit()
                Image("gallery_4").resizable().scaledToFit()
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
