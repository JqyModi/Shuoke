//
//  RecordWireframe.swift
//  HandWriting
//
//  Created by mac on 17/9/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit

class RecordWireframe: HandWritingWireframe, VideoDetailDelegate{
    var viewController: UIViewController?
    
    //代表阅读类
    func presentStudyDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideStudyDetailViewController(detailData: detailData)
        serviceLocator.provideUserNavigator()?.push(viewController: viewController)
    }
    //代表碑帖类
    func presentCopyBookDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideCopyBookDetailViewController(detailData: detailData)
        serviceLocator.provideUserNavigator()?.push(viewController: viewController)
    }
    //代表讲义类
    func presentLectureDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideLectureDetailViewController(detailData: detailData)
        serviceLocator.provideUserNavigator()?.push(viewController: viewController)
    }
    
    var videoDetailViewController: VideoDetailViewController?
    func presentVideoDetailViewController(item: Video) {
        videoDetailViewController = serviceLocator.provideVideoDetailViewController(item: item)
        //serviceLocator.provideVideoNavigator()?.push(viewController: videoDetailViewController)
        videoDetailViewController?.delegate = self
        serviceLocator.provideVideoNavigator()?.present(videoDetailViewController!, animated: true, completion: {
            self.videoDetailViewController?.autoPlay()
        })
    }
    
    func playerBack(viewController: VideoDetailViewController) {
        viewController.dismiss(animated: true, completion: {
            viewController.show(self.videoDetailViewController!, sender: nil)
        })
    }
    
    func configNavigationBar(viewController: WritingDetailViewController) {
        let rightButton = UIBarButtonItem(title: "确定", style: .plain, target: viewController.self, action: Selector("rightAction"))
        viewController.navigationItem.setRightBarButton(rightButton, animated: true)
    }
}
