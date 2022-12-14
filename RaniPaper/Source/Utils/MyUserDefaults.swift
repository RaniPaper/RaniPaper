//
//  MyUserDefaults.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/02.
//

import Foundation

final class MyUserDefaults {
    static var shared = MyUserDefaults()
    var defaults = UserDefaults.standard
    
    init(){
        print("✅ MyUserDefaults init")
    }
    
    func setValue(key: String, value: Any?){
        defaults.set(value, forKey: key)
    }
    
    func getValue(key: String) -> Any? {
        if let value = defaults.object(forKey: key){
            return value
        } else {
            print("키 \(key)에 해당하는 값이 없습니다")
            return nil
        }
    }
}
