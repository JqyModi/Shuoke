//
//  Common.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
/*
 http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=1&type=yuedu&pid=411
 {
 "success":true,
 "error_code":0,
 "message":"数据加载完毕",
 "data":[
 {
 "id":"1115",
 "title":"广东“女子书法十家”作品展佛山开幕",
 //http://shuoke360.cn/Public/Uploads/Article/20170607/thumb_59375e07c83be.jpg
 "img_url_s":"/Public/Uploads/Article/20170607/thumb_59375e07c83be.jpg",
 "view_count":"18"
 },
 {
 "id":"1114",
 "title":"广东中青年书法家“一带一路”系列书法展首站在中山启动",
 "img_url_s":"/Public/Uploads/Article/20170607/thumb_59376fefd13b2.jpg",
 "view_count":"12"
 }
 ]
 }
 */
class Common {
    //    let name: String
    //    let thumbnail: URL
    
    var id: String
    var title: String
    var img_url_s: String
    var view_count: Int
    var video: String
    init(id: String,title: String,img_url_s: String,view_count: Int) {
        self.id = id
        self.title = title
        self.img_url_s = img_url_s
        self.view_count = view_count
        self.video = ""
    }
    init(id: String,title: String,img_url_s: String,view_count: Int,video: String) {
        self.id = id
        self.title = title
        self.img_url_s = img_url_s
        self.view_count = view_count
        self.video = video
    }
}
