//
//  HapticManager.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/05.
//

import Foundation
import UIKit

// MARK: 사용 예시
// HapticManager.shared.notification(type: .warning)
// HapticManager.shared.notification(type: .error)
// HapticManager.shared.notification(type: .success)

// HapticManager.shared.impact(style: .heavy)
// HapticManager.shared.impact(style: .light)
// HapticManager.shared.impact(style: .medium)
// HapticManager.shared.impact(style: .rigid)
// HapticManager.shared.impact(style: .soft)

class HapticManager {
    static let shared = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func notification(success: Bool) {
        let generator = UINotificationFeedbackGenerator()
        success ? generator.notificationOccurred(.success) : generator.notificationOccurred(.error)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    
}


