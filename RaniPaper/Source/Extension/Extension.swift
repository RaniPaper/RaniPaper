//
//  Extension.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/23.
//

import SwiftUI

extension Color
{
    init(hexcode: String) {
           let scanner = Scanner(string: hexcode)
           var rgbValue: UInt64 = 0
           scanner.scanHexInt64(&rgbValue)

           let red = (rgbValue & 0xff0000) >> 16
           let green = (rgbValue & 0xff00) >> 8
           let blue = rgbValue & 0xff

           self.init(red: Double(red)/0xff, green: Double(green)/0xff, blue: Double(blue)/0xff)
       }
    
    
    public static var darkGreen:Color{
        return Color.init(hexcode: "49733E")
    }
    
    public static var green1:Color{
        return Color.init(hexcode: "7FAA1E")
    }
    
    public static var lightGreen:Color{
        return Color.init(hexcode: "D2ED60")
    }
    
    public static var brown1:Color{
        return Color.init(hexcode: "4E3F0F")
    }
    
    public static var lightBrown:Color{
        return Color.init(hexcode: "84764F")
    }
    
    
    
    
}
