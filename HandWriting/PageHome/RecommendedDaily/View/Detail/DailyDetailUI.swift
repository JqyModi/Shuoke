//
//  DailyDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
protocol DailyDetailUI: BothamUI, BothamLoadingUI {
    
    var title: String? { get set }
    
    func show(item: URL)
    
}
