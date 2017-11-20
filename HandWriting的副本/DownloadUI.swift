//
//  DownloadUI.swift
//  HandWriting
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
//导入UI框架类
import BothamUI

protocol DownloadUI: BothamUI, BothamPullToResfreshUI {
    func show(items: [Download])
}
