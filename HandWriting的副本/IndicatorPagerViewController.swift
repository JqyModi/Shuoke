//
//  IndicatorPagerViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/2.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class IndicatorPagerViewController: TabmanViewController, PageboyViewControllerDataSource, TabmanBarDelegate {

    override func viewDidLoad() {
        
        self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
        
        
        super.viewDidLoad()
        
        
        self.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        // return array of view controllers
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor.brown
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor.red
        
        let viewControllers = [viewController1, viewController2]
        
        // configure the bar
        self.bar.items = [Item(title: "Page 1"),
                          Item(title: "Page 2")]
//        bar.style = .bar
        bar.style = .custom(type: CustomPagerBar.self)
        bar.location = .bottom
        bar.delegate = self
        
        
        return viewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        // use default index
        return PageIndex.last
    }
    
    func bar(shouldSelectItemAt index: Int) -> Bool {
        
        return true
    }
    
    
}


