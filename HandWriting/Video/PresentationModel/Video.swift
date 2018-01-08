//
//  Video.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
/*
 http://shuoke360.cn/api/video?token=gstshuoke360&jiegou=559&bianpang=458&bihua=431&class=619&page=1
 data:[
 {
 "id":"4225",
 "class":"619",
 "bihua":"431",
 "bianpang":"458",
 "jiegou":"559",
 "lizi":"633",
 "name":"测试41",
 "img_url":"/Public/Uploads/Video/20170525/59264c0220a06.jpg",
 "img_url_s":"/Public/Uploads/Video/20170525/thumb_59264c0220a06.jpg",
 "video_url":"/Public/Uploads/Video/20170525/59264c0e8d116.mp4",
 "font":"1",
 "remark":"",
 "ishot":"0",
 "isrec":"0",
 "status":"1",
 "sort":"1",
 "dateline":"1495682074",
 "view_count":"13",
 "title":"",
 "keywords":"",
 "description":"",
 "typeid":null
 }]
*/

struct Video {
    let name: String
    let img_url: String
    let img_url_s: String
    let video_url: String
}













