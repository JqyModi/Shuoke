//
//  BothamLoadToRefresh.swift
//  HandWriting
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

public protocol BothamLoadToRefresh {
    var loadToRefreshHandler: BothamLoadToRefreshHandler! { get }
}

public extension BothamLoadToRefresh {
    public func stopRefreshing() {
        loadToRefreshHandler.endRefreshing()
    }
}
