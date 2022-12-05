//
//  UserState.swift
//  RaniPaper
//
//  Created by YoungK on 2022/12/05.
//

import Foundation

class UserState: ObservableObject {
    static let shared = UserState()
    
    @Published var userType: UserType
    
    init() {
        print("✅ UserState 생성")
        self.userType = .none
        fetch()
    }
    
    func fetch() {
        guard let userTypeString: String = UserDefaults.standard.object(forKey: "userType") as? String else { return }
        print("userType 을 불러왔습니다: \(userTypeString)")
        
        switch userTypeString {
        case "none":
            self.userType = .none
            
        case "fan":
            self.userType = .fan
            
        case "viichan":
            self.userType = .viichan
            
        default:
            self.userType = .none
        }
        
    }
    
    func update(_ userType: UserType) {
        print("userType 을 저장합니다: \(userType)")
        UserDefaults.standard.set(userType.rawValue, forKey: "userType")
        fetch()
    }
}
