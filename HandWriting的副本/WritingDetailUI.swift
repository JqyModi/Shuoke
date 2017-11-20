//
//  WritingDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
protocol WritingDetailUI: BothamUI, BothamLoadingUI, BothamPullToResfreshUI {
    
    var title: String? { get set }
    
//    func configureHeader(_ writing: Writing)
    func show(items: [WritingDetail])
    
}
