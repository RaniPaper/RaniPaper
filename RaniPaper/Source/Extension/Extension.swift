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

extension UIDevice {

    var hasNotch: Bool {

        if #available(iOS 15.0, *) {
            let bottom = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first?.safeAreaInsets.bottom ?? 0

            return bottom > 0

        } else {
            let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        }
        // UIWindowScene.windows
    }
}

extension Font{
    public static func efDiary(_ size:CGFloat = 10)->Font{
        return Font.custom("EF_Diary",size: size)
    }
    
    public static func beomsuk(_ size:CGFloat = 10)->Font{
        return Font.custom("Undefined",size: size)
    }
    
    public static func jua(_ size:CGFloat = 10)->Font{
        return Font.custom("BMJUAOTF",size: size)
    }
    
    public static func samanco(_ size:CGFloat = 10)->Font{
        return Font.custom("BinggraeSamanco-Bold",size: size)
    }
    
    public static func kotra(_ size:CGFloat = 10)->Font{
        return Font.custom("KOTRAHOPE",size: size)
    }
    public static func oneMobileTilte(_ size:CGFloat = 10)->Font{
        return Font.custom("ONE Mobile Title OTF",size: size)
    }
    public static func oneMobileRegular(_ size:CGFloat = 10)->Font{
        return Font.custom("Optima",size: size)
    }
    public static func gangwonBold(_ size:CGFloat = 10)->Font{
        return Font.custom("GangwonEduAll-OTFBold",size: size)
    }
    
    
    
    
   
    
    
    
}

extension ViewSelection: Equatable{
    var Name: String{
        switch self {
        case .home: return "home"
        case .diary: return "diary"
        case .memo: return "memo"
        case .info: return "info"
        case .credit: return "credit"
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool{
        return lhs.Name == rhs.Name
    }
}
