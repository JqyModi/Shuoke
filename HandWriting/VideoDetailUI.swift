//
//  VideoDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

protocol VideoDetailUI: BothamUI {
    
    var title: String? {get set}
    
    func show(item: Video)
}
