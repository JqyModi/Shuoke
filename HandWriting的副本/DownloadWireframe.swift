//
//  DownloadWireframe.swift
//  HandWriting
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit

class DownloadWireframe: HandWritingWireframe {
    var viewController: UIViewController?
    var document: UIDocumentInteractionController?
//    var document: QLPreviewController?
    var view: UIView?
    var url: URL?
    //代表讲义类
    func presentLectureDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideLectureDetailViewController(detailData: detailData)
        serviceLocator.provideUserNavigator()?.push(viewController: viewController)
    }
    
    //代表讲义类
    func presentDownloadDetailViewController(_ url: URL) {
        //        QuickLookViewController *quickLookVC = [[QuickLookViewController alloc]init];
        //        quickLookVC.fileURL = URL;
        //        [self.navigationController pushViewController:quickLookVC animated:YES];
        
//        let quickLookVC = QuickLookViewController()
//        quickLookVC.fileURL = url
//        serviceLocator.provideUserNavigator()?.push(viewController: quickLookVC)
        
//        DocumentInteractionViewController *documentVC = [[DocumentInteractionViewController alloc]init];
//        [documentVC openFileWithURL:URL];
//        [self.navigationController pushViewController:documentVC animated:YES];
//        let documentVC = DocumentInteractionViewController()
//        documentVC.openFile(with: url)
//        serviceLocator.provideUserNavigator()?.push(viewController: documentVC)
        document = UIDocumentInteractionController(url: url)
        view = serviceLocator.provideUserNavigator()?.view
//        document?.presentOpenInMenu(from: (view?.bounds)!, in: view!, animated: true)
//        document?.presentOptionsMenu(from: (view?.bounds)!, in: view!, animated: true)
        document?.delegate = self

        document?.presentPreview(animated: true)
        
//        self.url = url
//        document = QLPreviewController()
//        document?.delegate = self
//        document?.dataSource = self
//        serviceLocator.provideUserNavigator()?.push(viewController: document!)
    }
    
    func configNavigationBar(viewController: WritingDetailViewController) {
        let rightButton = UIBarButtonItem(title: "确定", style: .plain, target: viewController.self, action: Selector("rightAction"))
        viewController.navigationItem.setRightBarButton(rightButton, animated: true)
    }
}
extension DownloadWireframe: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return serviceLocator.provideUserNavigator()!
    }
}
//extension DownloadWireframe: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
//    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
//        return 1
//    }
//
//    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        return self.url as! QLPreviewItem
//    }
//}

