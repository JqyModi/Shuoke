//
//  SightDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
protocol SightDetailUI: BothamUI, BothamLoadingUI {
    
    var title: String? { get set }
    
    //    func configureHeader(_ writing: Writing)
    func show(item: URL)
    
}
