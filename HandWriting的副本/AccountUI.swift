//
//  AccountUI.swift
//  HandWriting
//
//  Created by mac on 9/5/17.
//  Copyright © 2017 modi. All rights reserved.
//

import Foundation
import BothamUI
protocol AccountUI: BothamUI {
    
    var title: String? { get set }
    
    func show(items: [Account])
    
    func showDialog(account: Account)
    
//    func refreshItem()
    
}
