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
                Image("gallery_first").resizable().scaledToFit()
                Image("gallery_n").resizable().scaledToFit()
                Image("gallery_last").resizable().scaledToFit()
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
