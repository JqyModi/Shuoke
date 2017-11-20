//
//  WritingUI.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

protocol WritingUI: BothamUI {
    func show(items: [Writing])
}
