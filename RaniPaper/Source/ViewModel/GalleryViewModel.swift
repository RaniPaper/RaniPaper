//
//  GalleryViewModel.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/17.
//

import Foundation
import Combine

class GalleryViewModel: ObservableObject {
    let list: [RollingPaper]
    @Published var isAllUnlocked: Bool = false
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        var filteredList = MyUserDefaults.rollingPaperList?.filter({ $0.isUnlocked == true })
        //var filteredList: [RollingPaper]? = rollingPaperList // 테스트용
        
        filteredList?.indices.forEach { i in
            filteredList?[i].position = offsets[i]
        }
        list = filteredList ?? []
        
        MyUserDefaults.$rollingPaperList.sink { _ in } receiveValue: { [weak self] rollingPaperList in
            guard let self else { return }
            guard let rollingPaperList else { return }
            
            let totalCount = rollingPaperList.count
            let unLockedCount = rollingPaperList.filter { $0.isUnlocked == true }.count
            
            self.isAllUnlocked = (unLockedCount == totalCount)
            
        }.store(in: &subscriptions)
        
        
        print("✅ GalleryViewModel 생성")
    }
    
    deinit{
        print("❌ GalleryViewModel 소멸")
    }
    
}

fileprivate let offsets: [CGSize] = [
    CGSize(width: 0, height: 0),CGSize(width: 125, height: 91),CGSize(width: 16, height: 224),CGSize(width: 212, height: 218),CGSize(width: 50, height: 369),
    CGSize(width: 156, height: 494),CGSize(width: 275, height: 12),CGSize(width: 377, height: 148),CGSize(width: 275, height: 369),CGSize(width: 365, height: 505),
    CGSize(width: 524, height: 12),CGSize(width: 655, height: 128),CGSize(width: 522, height: 218),CGSize(width: 449, height: 369),CGSize(width: 577, height: 498),
    CGSize(width: 803, height: 12),CGSize(width: 928, height: 105),CGSize(width: 799, height: 224),CGSize(width: 640, height: 355),CGSize(width: 780, height: 480),
    CGSize(width: 918, height: 361),CGSize(width: 1087, height: 18),CGSize(width: 1201, height: 148),CGSize(width: 1081, height: 242),CGSize(width: 1175, height: 372),
    CGSize(width: 1043, height: 480),CGSize(width: 1310, height: 245),CGSize(width: 1298, height: 468),CGSize(width: 1429, height: 12),CGSize(width: 1469, height: 179),
    CGSize(width: 1445, height: 361),CGSize(width: 1528, height: 511),CGSize(width: 1638, height: 18),CGSize(width: 1653, height: 236),CGSize(width: 1697, height: 386),
    CGSize(width: 1779, height: 120),CGSize(width: 1837, height: 497),CGSize(width: 1920, height: 23),CGSize(width: 1884, height: 257),CGSize(width: 2037, height: 123),
    CGSize(width: 2029, height: 351),CGSize(width: 2045, height: 497),CGSize(width: 2178, height: 12),CGSize(width: 2207, height: 203),CGSize(width: 2195, height: 392),
    CGSize(width: 2387, height: 23),CGSize(width: 2447, height: 174),CGSize(width: 2350, height: 329),CGSize(width: 2366, height: 486),CGSize(width: 2523, height: 392),
    CGSize(width: 2636, height: 43),CGSize(width: 2642, height: 226),CGSize(width: 2669, height: 476),CGSize(width: 2809, height: 141),CGSize(width: 2799, height: 361),
    CGSize(width: 2888, height: 497),CGSize(width: 2944, height: 29),CGSize(width: 2950, height: 248),CGSize(width: 3034, height: 391),CGSize(width: 3079, height: 123),
    CGSize(width: 3206, height: 16),CGSize(width: 3159, height: 266),CGSize(width: 3180, height: 497),CGSize(width: 3314, height: 163),CGSize(width: 3300, height: 361),
    CGSize(width: 3437, height: 38),CGSize(width: 3457, height: 288),CGSize(width: 3437, height: 470),CGSize(width: 3572, height: 143),CGSize(width: 3609, height: 391),
    CGSize(width: 3682, height: 16),CGSize(width: 3707, height: 247),CGSize(width: 3712, height: 500),CGSize(width: 3807, height: 122),CGSize(width: 3821, height: 391),
    CGSize(width: 3946, height: 16),CGSize(width: 3932, height: 226),CGSize(width: 3990, height: 392),CGSize(width: 4121, height: 38),CGSize(width: 4102, height: 217),
    CGSize(width: 4165, height: 382),CGSize(width: 4086, height: 507),CGSize(width: 4290, height: 16),CGSize(width: 4258, height: 168),CGSize(width: 4332, height: 329),
    CGSize(width: 4315, height: 500),CGSize(width: 4473, height: 38),CGSize(width: 4440, height: 190),CGSize(width: 4485, height: 382),CGSize(width: 4655, height: 16),
    CGSize(width: 4621, height: 228),CGSize(width: 4711, height: 375),CGSize(width: 4598, height: 507),CGSize(width: 4757, height: 150),CGSize(width: 4899, height: 16),
    CGSize(width: 4858, height: 267),CGSize(width: 4813, height: 500),CGSize(width: 4938, height: 419),CGSize(width: 5014, height: 168),CGSize(width: 5150, height: 27),
    CGSize(width: 5098, height: 313),CGSize(width: 5077, height: 500),CGSize(width: 5206, height: 174),CGSize(width: 5216, height: 437),CGSize(width: 5333, height: 16),
    CGSize(width: 5331, height: 288),CGSize(width: 5396, height: 482),CGSize(width: 5430, height: 152),CGSize(width: 5621, height: 16),CGSize(width: 5589, height: 168),
    CGSize(width: 5532, height: 326),CGSize(width: 5622, height: 506),CGSize(width: 5804, height: 38),CGSize(width: 5740, height: 225),CGSize(width: 5777, height: 384),
    CGSize(width: 5894, height: 513),CGSize(width: 6007, height: 16),CGSize(width: 5956, height: 168),CGSize(width: 5956, height: 353),CGSize(width: 6154, height: 128),
    CGSize(width: 6116, height: 303),CGSize(width: 6097, height: 482),CGSize(width: 6288, height: 27),CGSize(width: 6308, height: 253),CGSize(width: 6257, height: 420),
    CGSize(width: 6418, height: 116),CGSize(width: 6468, height: 317),CGSize(width: 6413, height: 483),CGSize(width: 6565, height: 16),CGSize(width: 6593, height: 190),
    CGSize(width: 6611, height: 366),CGSize(width: 6736, height: 53),CGSize(width: 6743, height: 241),CGSize(width: 6718, height: 491),CGSize(width: 6907, height: 16),
    CGSize(width: 6889, height: 194),CGSize(width: 6853, height: 382),CGSize(width: 7051, height: 116),CGSize(width: 7032, height: 321),CGSize(width: 6992, height: 478)
]
