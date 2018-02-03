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

}
