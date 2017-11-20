//
//  HandWritingViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import Tabman
class HandWritingViewController: BothamViewController, BothamLoadingViewController, BothamPullToRefresh {
    
    let loadingView: UIView = {
        let loadingView = BothamLoadingView()
        loadingView.color = UIColor.loadingColor
        return loadingView
    }()
    
    var pullToRefreshHandler: BothamPullToRefreshHandler!
    
    var loadToRefreshHandler: BothamLoadToRefreshHandler!
    
//    open var presenter: BothamPresenter! = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter.viewDidLoad()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        presenter.viewWillAppear()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        presenter.viewDidAppear()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        presenter.viewWillDisappear()
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        presenter.viewDidDisappear()
//    }
}
