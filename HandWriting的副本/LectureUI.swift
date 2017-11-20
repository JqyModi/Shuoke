//
//  LectureUI.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
//导入UI框架类
import BothamUI

protocol LectureUI: BothamUI, BothamPullToResfreshUI{
    func show(items: [Common])
}
