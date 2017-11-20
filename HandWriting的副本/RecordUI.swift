//
//  RecordUI.swift
//  HandWriting
//
//  Created by mac on 17/9/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
//导入UI框架类
import BothamUI

protocol RecordUI: BothamUI, BothamPullToResfreshUI {
    func show(items: [Record])
}
