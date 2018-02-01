//
//  HeaderModel.swift
//  HandWriting
//
//  Created by mac on 2018/2/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class HeaderModel: NSObject {
    var nick: String = "—"
    var school: String = "—"
    var loginOrInfoText: String = "点击登录?"
    var iconView: String = ""
    
    init(nick: String, school: String, loginOrInfoText: String, iconView: String) {
        self.nick = nick
        self.school = school
        self.loginOrInfoText = loginOrInfoText
        self.iconView = iconView
    }
}
