//
//  HomePageViewNavigationController.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
class HomePageViewNavigationController: UINavigationController {
    internal override class func initialize() {
        super.initialize()
        
        let navBar = UINavigationBar.appearance()
        // modi 设置导航栏颜色
        //        navBar.barTintColor = YMGlobalRedColor()
        navBar.barTintColor = UIColor.red
        
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
    }
}
