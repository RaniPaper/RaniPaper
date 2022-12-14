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
    
    @UserDefaultWrapper(key: "rollingPaperList", defaultValue: nil)
    static var rollingPaperList: [RollingPaper]?
    
    init() {
        print("✅ MyUserDefaults init")
    }
    
    func setValue(key: String, value: Any?){
        defaults.set(value, forKey: key)
    }
    
    func getValue(key: String) -> Any {
        if let value = defaults.object(forKey: key){
            return value
        } else {
            print("키 \(key)에 해당하는 값이 없습니다")
            return false
        }
    }
}

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
    
}
