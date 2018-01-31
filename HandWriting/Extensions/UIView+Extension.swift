//
//  UIView+Extension.swift
//  SinaWeibo
//
//  Created by apple on 15/11/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

extension UIView {
    
    //通过响应者链条 找到导航控制器
    func NavController() -> UINavigationController? {
        //遍历响应者链条 
        
        //获取当前视图对象的下一个响应者
        var next = self.next
        repeat {
            if next is UINavigationController {
                return next as? UINavigationController
            }
            next = next?.next
        
        } while (next != nil)
        
        return nil
    }
}
