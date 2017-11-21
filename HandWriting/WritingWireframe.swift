//
//  WritingWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
@objc protocol WritingWireframeDelegate{
    func selItem(detailName: String, title: String)
}
class WritingWireframe: HandWritingWireframe, WritingDetailDelegate {
    var viewController: UIViewController?
    var delegate: WritingWireframeDelegate?
    
    func presentWritingDetailViewController(_ writingName: String) {
        viewController = serviceLocator.provideWritingDetailViewController(writingName)
        //
        configNavigationBar(viewController: viewController! as! WritingDetailViewController)
        serviceLocator.provideWritingNavigator()?.push(viewController: viewController!)
    }
    
    func presentWritingStartViewController(_ data: NSMutableDictionary) {
        viewController = serviceLocator.provideWritingStartViewController(data)
//        let rightButton = UIBarButtonItem(title: "确定", style: .plain, target: viewController.self, action: Selector("rightAction"))
//        viewController?.navigationItem.setRightBarButton(rightButton, animated: true)
        serviceLocator.provideWritingNavigator()?.push(viewController: viewController!)
    }
    
    func configNavigationBar(viewController: WritingDetailViewController) {
        viewController.detailDelegate = self
        let rightButton = UIBarButtonItem(title: "确定", style: .plain, target: viewController.self, action: Selector("rightAction"))
        viewController.navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    func popView(detailName: String, selTitle: String) {
        delegate?.selItem(detailName: detailName, title: selTitle)
    }
}
