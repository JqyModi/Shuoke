//
//  HWNavigationController.swift
//  HandWriting
//
//  Created by mac on 17/9/11.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class HWNavigationController: UINavigationController {
    
    internal override class func initialize() {
        super.initialize()
        
        let navBar = UINavigationBar.appearance()
        // modi 设置导航栏颜色
        //        navBar.barTintColor = YMGlobalRedColor()
        navBar.barTintColor = UIColor.tabBarColor
        
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    
}
