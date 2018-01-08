//
//  BothamPullToRefreshHandler.swift
//  HandWriting
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

open class BothamLoadToRefreshHandler: NSObject {
    let presenter: BothamLoadToRefreshPresenter
    let refreshControl = UIRefreshControl()
    
    public init(presenter: BothamLoadToRefreshPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    open func addTo(scrollView: UIScrollView) {
        refreshControl.addTarget(self, action: .refresh, for: .valueChanged)
        scrollView.addSubview(refreshControl)
        scrollView.alwaysBounceVertical = true
    }
    
    open func remove() {
        refreshControl.removeTarget(self, action: .refresh, for: .valueChanged)
        refreshControl.removeFromSuperview()
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        presenter.didStartLoadRefreshing()
    }
    
    open func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    open func beginLoadRefreshing(_ scrollView: UIScrollView) {
        //上拉加载触发点
        let temp = refreshControl.frame.size.height
        debugPrint("temp = \(temp)")
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height), animated: true)
        self.refreshControl.beginRefreshing()
        
//        if ( currentOffsetY + scrollView.frame.size.height  > scrollView.contentSize.height){
//            [self.loadMoreView startAnimation];//开始旋转菊花
//            [self loadMore];
//        }
//
//        if scrollView.contentOffset.y >= max(0, scrollView.contentSize.height - scrollView.frame.size.height) + 50{
            // 加载更多
//            self.footerLabel.text = "松开加载"
//        } else {
//            self.footerLabel.text = "上啦加载"
//        }
    }
}

private extension Selector {
    static let refresh = #selector(BothamLoadToRefreshHandler.refresh(refreshControl:))
}
