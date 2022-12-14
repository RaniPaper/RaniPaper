//
//  RaniPaperApp.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/20.
//

import SwiftUI

@main
struct RaniPaperApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(UserState.shared)
                
        }
    }
}
