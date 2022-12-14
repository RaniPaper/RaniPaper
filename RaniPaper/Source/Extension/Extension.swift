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
    
    public static var memoBg:Color{
        return Color.init(hexcode: "F3EFCC")
    }
    
    public static var memoPrimary:Color{
        return Color.init(hexcode: "BF9C9C")
    }
    
    public static var memoDropDownBg:Color{
        return Color.init(hexcode: "DEC7A5")
    }
    public static var memoDropDownText:Color{
        return Color.init(hexcode: "8E6868")
    }
    
    public static var settingToggleOff:Color{
        return Color.init(hexcode: "ADC9B3")
    }
    
    public static var settingToggleOn:Color{
        return Color.init(hexcode: "D3ECD0")
    }
    
    public static var settingBoldLine:Color{
        return Color.init(hexcode: "A9C9A5")
    }
    
    public static var onBoardBackground:Color{
        return Color.init(hexcode: "F9FFF9")
    }
    
    public static var onBoardBorder:Color{
        return Color.init(hexcode: "769873")
    }
    
    public static var onBoardDefault:Color{
        return Color.init(hexcode: "B2BFAC")
    }
    
    public static var onBoardRed:Color{
        return Color.init(hexcode: "E86988")
    }
    
    public static var onBoardGreen:Color{
        return Color.init(hexcode: "599E58")
    }
    
    public static var menuHomeOnPress:Color{
        return Color.init(hexcode: "FFC5BC")
    }
    
    public static var menuCreditOnPress:Color{
        return Color.init(hexcode: "D3DF88")
    }
    
    public static var menuOnPress:Color{
        return Color.init(hexcode: "C0E4C0")
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
    
    public static func chosun(_ size:CGFloat = 10)->Font{
        return Font.custom("ChosunilboNM",size: size)
    }
    
    public static func nanum(_ size:CGFloat = 10)->Font{
        return Font.custom("NanumHaNaSonGeurSsi",size: size)
    }
    
    
    
    
    
}

extension ViewSelection: Equatable{
    var Name: String{
        switch self {
        case .home: return "home"
        case .diary: return "diary"
        case .memo: return "memo"
        case .setting: return "setting"
        case .info: return "info"
        case .credit: return "credit"
        }
    }
    
    var ButtonName: String{
        switch self{
        case .home: return "???"
        case .diary: return "????????????"
        case .memo: return "??????"
        case .setting: return "??????"
        case .info: return "??? ??????"
        case .credit: return "?????????"
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool{
        return lhs.Name == rhs.Name
    }
}

extension Date {
    
    func getAllDates()->[Date]{
        let calendar = Calendar.current // ?????? ??????
        
        // year??? month??? ????????? ????????? , self ?????? ??? date ????????? ??????
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        
        
        let range = calendar.range(of: .day, in: .month, for: startDate)! //???????????? ?????? ????????? ???????????? ?????????
        
        //(1..<31) ,(1..<32) ??? range??? ??????
        
       
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day-1 , to: startDate)!
        }
    }
    
    static let dateformat: DateFormatter = { //????????? ?????????
           let formatter = DateFormatter()
            formatter.dateFormat = "YYYY.M.dd"
            return formatter
        }()
    
    // ?????? ????????? true ??????
        func isSameDay(with date2: Date)-> Bool {
            let calendar = Calendar.current
            return calendar.isDate(self, inSameDayAs: date2)
        }
    
}

extension Array {
    mutating func popFirst() -> Element? {
        return self[self.indices].popFirst()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // ????????? ?????????
    }
}
