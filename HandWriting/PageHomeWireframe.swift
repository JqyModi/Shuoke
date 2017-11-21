//
//  PageHomeWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
class PageHomeWireframe: HandWritingWireframe {
    func presentDailyDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideDailyDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
//        let temp = serviceLocator.provideDailyViewController()
//        temp.navigationController?.navigationBar.isHidden = false
//        temp.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentSightDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideSightDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
    }
    
    func presentFamousDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideFamousDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
    }
    
    func presentStudyDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideStudyDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
    }
    
    func presentCopyBookDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideCopyBookDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
    }
    
    func presentLectureDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideLectureDetailViewController(detailData: detailData)
        //值传递
        hiddenNavigationBar(viewController: viewController)
        serviceLocator.provideHomePageNavigator()?.push(viewController: viewController)
    }
    
    func hiddenNavigationBar(viewController: UIViewController){
        viewController.navigationController?.navigationBar.isHidden = false
    }
}
