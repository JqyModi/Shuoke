//
//  VideoCategory.swift
//  HandWriting
//
//  Created by mac on 17/9/4.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

class VideoCategory {
/*  {
    "id":"632",
    "isCheck":"fase",
    "val":"三年级上",
    "type":"class"
    }
     */
    
    var id: String
    var isCheck: Bool
    var val: String
    var type: String
    
    init(id: String, isCheck: Bool, val: String, type: String) {
        self.id = id
        self.isCheck = isCheck
        self.val = val
        self.type = type
    }
}
