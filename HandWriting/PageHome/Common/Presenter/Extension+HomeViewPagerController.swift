//
//  Extension+HomeViewPagerController.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
/*
 * 通过扩展操作ViewPager
 *
 */
extension HomeViewPagerController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabItems.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
//        //tabItems：被扩展中声明的属性，直接可以获取到
//        vc.itemText = "\(tabItems[position].title!)"
//        return vc
        debugPrint("item count = \(itemControllers.count)")
        let vc = itemControllers[position] as! UIViewController
        return vc
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabItems
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension HomeViewPagerController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        debugPrint("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        debugPrint("Moved to page \(index)")
    }
    
    
}
