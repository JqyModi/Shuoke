//
//  PageHomeWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
class PageHomeWireframe: HandWritingWireframe, VideoDetailDelegate {
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
    var videoDetailViewController: VideoDetailViewController?
    
    func presentVideoDetailViewController(item: Video) {
        videoDetailViewController = serviceLocator.provideVideoDetailViewController(item: item)
        videoDetailViewController?.delegate = self
        serviceLocator.provideVideoNavigator()?.present(videoDetailViewController!, animated: true, completion: {
            self.videoDetailViewController?.autoPlay()
        })
    }
    func presentVideoDetailViewController(_ detailData: NSMutableDictionary) {
        if let item = detailData["video"] as? Video {
            videoDetailViewController = serviceLocator.provideVideoDetailViewController(item: item)
            videoDetailViewController?.delegate = self
            //跳转
            if let svc = detailData["searchVC"] as? SearchViewController {
                svc.present(videoDetailViewController!, animated: true, completion: {
                    self.videoDetailViewController?.autoPlay()
                })
            }
        }
    }
    
    func playerBack(viewController: VideoDetailViewController) {
        viewController.dismiss(animated: true, completion: {
            viewController.show(self.videoDetailViewController!, sender: nil)
        })
    }
    
    func hiddenNavigationBar(viewController: UIViewController){
        viewController.navigationController?.navigationBar.isHidden = false
    }
}
