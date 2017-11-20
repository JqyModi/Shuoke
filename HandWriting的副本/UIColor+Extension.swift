//
//  UIColor+Extension.swift
//  YiBiFen
//
//  Created by Hanson on 16/10/13.
//  Copyright © 2016年 Hanson. All rights reserved.
//

import UIKit

extension UIColor {
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
