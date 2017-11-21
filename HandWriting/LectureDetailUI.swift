//
//  LectureDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
protocol LectureDetailUI: BothamUI, BothamLoadingUI {
    
    var title: String? { get set }
    
    func show(item: URL)
    
}
