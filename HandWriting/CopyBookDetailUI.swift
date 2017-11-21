//
//  CopyBookDetailUI.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

protocol CopyBookDetailUI: BothamUI, BothamLoadingUI {
    
    var title: String? { get set }
    
//    func configureHeader(_ copyBook: Common)
    func show(items: [CopyBookDetail])
    
}
