//
//  UIColor.swift
//  Example
//
//  Created by Pedro Vicente Gomez on 18/12/15.
//  Copyright © 2015 GoKarumi S.L. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(rgba: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0

        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6: 
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    debugPrint("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                debugPrint("Scan hex error")
            }
        } else {
            debugPrint("Invalid RGB string, missing '#' as prefix", terminator: "")
        }

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    static var windowBackgroundColor: UIColor {
        return UIColor(rgba: "#22282FFF")
    }

    static var loadingColor: UIColor {
        return UIColor(rgba: "#4D5B69FF")
    }

    static var tabBarColor: UIColor {
        return UIColor(rgba: "#4D5B69FF")
    }

    static var tabBarTintColor: UIColor {
        return UIColor(rgba: "#17D1FFFF")
    }

    static var navigationBarColor: UIColor {
        return UIColor(rgba: "#404B57FF")
    }

    static var navigationBarTitleColor: UIColor {
        return UIColor(rgba: "#F5F5F5FF")
    }

    static var gradientStartColor: UIColor {
        return UIColor(rgba: "#2C343C00")
    }

    static var gradientEndColor: UIColor {
        return UIColor(rgba: "#2C343CE5")
    }

    static var cellBackgroundColor: UIColor {
        return UIColor(rgba: "#22282fFF")
    }

    static var cellBackgroundHighlightedColor: UIColor {
        return UIColor(rgba: "#2C343FFF")
    }

    static var cellTextColor: UIColor {
        return UIColor(rgba: "#F5F5F5FF")
    }

    static var cellTextHighlightedColor: UIColor {
        return UIColor(rgba: "#17D1FFFF")
    }
    
    //MARK Modi
    static var tabBackgroundColor: UIColor {
        return UIColor(rgba: "#333366FF")
    }

    static var writingPadOutsideColor: UIColor {
        return UIColor(rgba: "#FF0000FF")
    }
    
    static var cellSpaceColor: UIColor {
        return UIColor(rgba: "#CCCCCCFF")
    }
    
    static var cellTextColorDarkGray: UIColor {
        return UIColor(rgba: "#797979FF")
    }
    
    static var pageBackgroundColorGray: UIColor {
        return UIColor(rgba: "#EBEBEBFF")
    }
    
    static var cellBackgroundColorGray: UIColor {
        return UIColor(rgba: "#CCCCFFFF")
    }
    
    static var tabIndicatorViewBackgroundColor: UIColor {
        return UIColor(rgba: "#9966CCFF")
    }
    
    static var tabIndicatorViewBackgroundColor1: UIColor {
        return UIColor(rgba: "#5E5B95FF")
    }
    
    static var loginViewThemeColor: UIColor {
        return UIColor(rgba: "#6EBEFFFF")
    }
    
    static var loginViewBGColor: UIColor {
        return UIColor(rgba: "#DDDDDDFF")
    }
    
    static var Tabbar1Color: UIColor {
        return UIColor(rgba: "#5Eaa95FF")
    }
    
    static var Tabbar2Color: UIColor {
//        return UIColor(rgba: "#009966FF")
        return UIColor(rgba: "#006666FF")
    }
    
    static var Tabbar3Color: UIColor {
        return UIColor(rgba: "#5A3D99FF")
    }
    
    static var Tabbar4Color: UIColor {
        return UIColor(rgba: "#006699FF")
    }
    
    static var SendCodeTextColor: UIColor {
        return UIColor(rgba: "#aaaaaaFF")
    }
    
    static var SendCodeBGColor: UIColor {
        return UIColor(rgba: "#eeeeeeFF")
    }
    //DialogColor
    static var DialogColor: UIColor {
        return UIColor(rgba: "#9100FFFF")
    }
    
    //主题色配置区
    static var BrownTextColor: UIColor {
        return UIColor(rgba: "#663300FF")
    }
    
    static var TableBackgroundColor: UIColor {
        return UIColor(rgba: "#EBEBEBFF")
    }
    
    static var TableBackgroundDarkColor: UIColor {
        return UIColor(rgba: "#333366FF")
    }
    
    //白天
    static var DayCellTextColor: UIColor {
        return UIColor(rgba: "#666666FF")
    }
    
    static var DayCellBackgroundColor: UIColor {
        return UIColor(rgba: "#FFFFFFFF")
    }
    
    static var DayCellTextBrownColor: UIColor {
        return UIColor(rgba: "#663300FF")
    }
    
    //晚上
    static var NightCellTextColor: UIColor {
        return UIColor(rgba: "#FBFBFBFF")
    }
    
    static var NightCellBackgroundColor: UIColor {
        return UIColor(rgba: "#7777AAFF")
    }
    
    static var NightCellTextBrownColor: UIColor {
        return UIColor(rgba: "#66E57FFF")
    }
}
