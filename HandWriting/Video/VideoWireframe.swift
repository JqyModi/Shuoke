//
//  VideoWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import ZFPlayer

class VideoWireframe: HandWritingWireframe, VideoDetailDelegate {
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
}
