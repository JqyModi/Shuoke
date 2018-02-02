//
//  UILabel+Extension.swift
//  SinaWeibo
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

//UILabel扩展

extension UILabel {
    
    
    //1.>文字
    //2.>文字大小
    //3.>文字的颜色
    
    //参数指定默认值  该参数 可以不传
    convenience init(title: String,size: CGFloat,color: UIColor,margin: CGFloat = 0) {
        self.init()
        text = title
        textAlignment = NSTextAlignment.center
        font = UIFont.systemFont(ofSize: size)
        textColor = color
        numberOfLines = 0
        if margin != 0 {
            preferredMaxLayoutWidth = SCREEN_WIDTH - 2 * margin
            textAlignment = .left
        }
        //设置大小
        sizeToFit()
    }
}
