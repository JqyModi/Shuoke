//
//  SearchModel.swift
//  HandWriting
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

class SearchModel {
//    {
//    "id":"1143",
//    "title":"王羲之得示帖",
//    "img_url_s":"/Public/Uploads/Beitie/20170603/thumb_5932620a72672.png",
//    "path":"",
//    "dateline":"1496474147",
//    "model":"beitie",
//    "view_count":"2"
//    }
    var id: String
    var title: String
    var imgUrls: String
    var path: String
    var dateline: String
    var model: String
    var viewCount: Int
    
    init(dict: [String: Any]) {
        id = dict["id"] as? String ?? "0"
        title = dict["title"] as? String ?? ""
        imgUrls = dict["img_url_s"] as? String ?? ""
        path = dict["path"] as? String ?? ""
        dateline = dict["dateline"] as? String ?? ""
        model = dict["model"] as? String ?? ""
        viewCount = dict["view_count"] as? Int ?? 0
    }
}
