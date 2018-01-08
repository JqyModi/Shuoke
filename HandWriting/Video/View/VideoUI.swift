//
//  VideoUI.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

protocol VideoUI: BothamUI, BothamPullToResfreshUI {
    func show(items: [Video])
//    func loadMoreData(items: [Video])
}
