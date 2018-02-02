//
//  RootWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import UIKit

class RootWireframe: HandWritingWireframe {
    var tabs: [UIViewController] = []
    
    func presentInitialViewController(inWindow window: UIWindow) {
        let viewController = serviceLocator.provideRootTabBarController()
        tabs = self.tabsViewControllers()
        viewController.viewControllers = tabs
        let tabBar = viewController.tabBar
        configureTabBarItems(tabBar)
        window.rootViewController = viewController
    }
    
    private func tabsViewControllers() -> [UIViewController] {
        //
        NotificationCenter.default.addObserver(self, selector: #selector(RootWireframe.toUserView(_:)), name: NSNotification.Name(rawValue: NotifyToUserView), object: nil)
        
        let homePageViewNavigationController = serviceLocator.provideHomePageViewNavigationController()
        //隐藏导航栏／标题栏
//        hiddenNavigationBar(viewController: homePageViewNavigationController)
        naviStyle(viewController: homePageViewNavigationController, color: UIColor.Tabbar1Color)
        serviceLocator.navigatorContainer.register(navigationController: homePageViewNavigationController)
        
        let writingNavigationController = serviceLocator.provideWritingNavigationController()
//        hiddenNavigationBar(viewController: writingNavigationController)
        naviStyle(viewController: writingNavigationController, color: UIColor.Tabbar2Color)
        serviceLocator.navigatorContainer.register(navigationController: writingNavigationController)
        
        let videoNavigationController = serviceLocator.provideVideoNavigationController()
//        hiddenNavigationBar(viewController: videoNavigationController)
        naviStyle(viewController: videoNavigationController, color: UIColor.Tabbar3Color)
        serviceLocator.navigatorContainer.register(navigationController: videoNavigationController)
        
        let userNavigationController = serviceLocator.provideUserNavigationController()
//        hiddenNavigationBar(viewController: userNavigationController)
        configureNavigationBar(viewController: userNavigationController, color: UIColor.Tabbar4Color)
        serviceLocator.navigatorContainer.register(navigationController: userNavigationController)
        
        //MARK: - HOMETABBAR register
        let dailyNavigationController = serviceLocator.provideDailyNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: dailyNavigationController)
        
        let sightNavigationController = serviceLocator.provideSightNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: sightNavigationController)
        
        let famousNavigationController = serviceLocator.provideFamousNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: famousNavigationController)
        
        let studyNavigationController = serviceLocator.provideStudyNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: studyNavigationController)
        
        let copyBookNavigationController = serviceLocator.provideCopyBookNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: copyBookNavigationController)
        
        let lectureNavigationController = serviceLocator.provideLectureNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: lectureNavigationController)
        
        //MARK: - Record register
        let recordNavigationController = serviceLocator.provideRecordNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: recordNavigationController)
        
        //MARK: - Download register
        let downloadNavigationController = serviceLocator.provideRecordNavigationController()
        serviceLocator.navigatorContainer.register(navigationController: downloadNavigationController)
        
        return [
            homePageViewNavigationController,
            writingNavigationController,
            videoNavigationController,
            userNavigationController
        ]
    }
    
    private func configureTabBarItems(_ tabBar: UITabBar) {
        //隐藏系统默认TabBar 使用CBMDTabbar
        tabBar.isHidden = true
        
//        tabBar.accessibilityLabel = "MainWireframe TabBar"
//        tabBar.tintColor = UIColor.tabBarTintColor
//
//        let homeIcon = UIImage(named: "heart")
//        let homeTabBarItem = tabBar.items?[0]
//        homeTabBarItem?.image = homeIcon?.withRenderingMode(.alwaysOriginal)
//        homeTabBarItem?.selectedImage = homeIcon
//
//        let writingIcon = UIImage(named: "news")
//        let writingTabBarItem = tabBar.items?[1]
//        writingTabBarItem?.image = writingIcon?.withRenderingMode(.alwaysOriginal)
//        writingTabBarItem?.selectedImage = writingIcon
//
//        let videoIcon = UIImage(named: "news")
//        let videoTabBarItem = tabBar.items?[2]
//        videoTabBarItem?.image = videoIcon?.withRenderingMode(.alwaysOriginal)
//        videoTabBarItem?.selectedImage = videoIcon
//
//        let userIcon = UIImage(named: "location")
//        let userTabBarItem = tabBar.items?[3]
//        userTabBarItem?.image = userIcon?.withRenderingMode(.alwaysOriginal)
//        userTabBarItem?.selectedImage = userIcon
    }
    /*
     隐藏导航栏
     */
    func hiddenNavigationBar(viewController: UINavigationController){
        viewController.setNavigationBarHidden(true, animated: true)
    }
    /*
     更改导航栏颜色
     */
    func naviStyle(viewController: UINavigationController, color: UIColor){
        viewController.navigationBar.tintColor = color
        viewController.navigationBar.barTintColor = color
    }
    
    private func configureNavigationBar(viewController: UINavigationController, color: UIColor) {
        viewController.navigationController?.navigationBar.backgroundColor = color
        viewController.navigationController?.navigationBar.isTranslucent = false
        viewController.navigationBar.tintColor = color
        viewController.navigationBar.barTintColor = color
        
//        viewController.navigationController?.navigationBar.shadowImage = UIImage()
//        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    func toUserView(_ notification: NSNotification){
        tabs.remove(at: 3)
        tabs.insert(serviceLocator.provideUserViewController(), at: 3)
    }
}
