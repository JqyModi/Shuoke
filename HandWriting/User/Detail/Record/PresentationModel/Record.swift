//
//  Record.swift
//  HandWriting
//
//  Created by mac on 17/9/18.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class Record {
    /*{
     "id":"381",
     "member_id":"1",
     "name":"曹全碑",
     "model":"beitie",
     "dateline":"1498264876"
     }*/
    
    var id: String?
    var member_id: String?
    var name: String?
    var model: String?
    var dateline: String?
    var url: String?
    
    init(dict: [String: Any]) {
        
//        if (dict["model"] as? String)! != "peixun" {
//            id = dict["id"] as? String? ?? "0"
//            member_id = dict["member_id"] as? String? ?? "no member_id"
//            name = dict["name"] as? String? ?? "no name"
//            model = dict["model"] as? String? ?? "no model"
//            dateline = dict["dateline"] as? String? ?? "no dateline"
//            url = (dict["url"] as? String?)!
//        }
        id = dict["id"] as? String? ?? "0"
        member_id = dict["member_id"] as? String? ?? "no member_id"
        name = dict["name"] as? String? ?? "no name"
        model = dict["model"] as? String? ?? "no model"
        dateline = dict["dateline"] as? String? ?? "no dateline"
        url = (dict["url"] as? String?)!
    }
    
}
