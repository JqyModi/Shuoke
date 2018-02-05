//
//  VideoDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import ZFPlayer

protocol VideoDetailDelegate {
    func playerBack(viewController: VideoDetailViewController)
}

class VideoDetailViewController: HandWritingViewController, VideoDetailUI ,ZFPlayerDelegate {
    var zfPlayerView: ZFPlayerView?
    var delegate: VideoDetailDelegate?
    
    weak var videoDetailViewController: VideoDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoDetailViewController = self
    }
    func show(item: Video) {
        zfPlayerView = ZFPlayerView()
        self.view.addSubview(zfPlayerView!)
        let controlView = ZFPlayerControlView()
        let playerModel = ZFPlayerModel()
        let videoUrl = BASEURL + item.video_url
        playerModel.videoURL = URL(string: videoUrl)
        playerModel.title = item.name
        playerModel.fatherView = self.view
        //playerModel.fatherViewTag = playerViewController.view.tag
        zfPlayerView?.playerControlView(controlView, playerModel: playerModel)
        zfPlayerView?.delegate = self
    }
    func zf_playerBackAction() {
        //重置播放器
        self.zfPlayerView?.pause()
        self.zfPlayerView?.resetPlayer()
        self.delegate?.playerBack(viewController: self.videoDetailViewController!)
        
        //返回
        self.dismiss(animated: true, completion: nil)
    }
    
    func autoPlay(){
        self.zfPlayerView?.autoPlayTheVideo()
    }
}
