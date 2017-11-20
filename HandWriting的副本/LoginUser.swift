//
//  LoginUser.swift
//  HandWriting
//
//  Created by mac on 17/9/11.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
// 如果上面直接运行会报错，因为你需要在要归档的对象中遵循NSCoding协议，并实现归档方法和解析方法 如：
class LoginUser: NSObject, NSCoding {
    /*
    "id":"1",
    "mob":"13528605866",
    "email":"354139903@qq.com",
    "password":"e10adc3949ba59abbe56e057f20f883e",
    "access_token":"3h71ho4g8vl1r0hg4402hsgunx26hosn",
    "nickname":"亲∩_∩",
    "type":"teacher",
    "name":"sandy",
    "avatar":"/Public/Uploads/avatar/20170809/1.jpg",
    "theme_url":"/Public/Uploads/Member/20170531/theme_1.jpg",
    "sex":"0",
    "createdate":"0",
    "login_count":"127",
    "lastlogindate":"1503559921",
    "lastloginip":"127.0.0.1",
    "lastlogin_area":"",
    "lastlogin_city":"内网IP",
    "reg_ip":"14.152.92.111",
    "reg_area":null,
    "reg_city":null,
    "status":"1",
    "points":"0",
    "addr":"",
    "school":"东莞中学",
    "class":"高一58班,高一59班",
    "teacher":null,
    "remark":"努力工作"
     */
    
    var id: Int?
    var mob: String?
    var email: String?
    var password: String?
    var access_token: String?
    var nick: String?
    var type: String?
    var name: String?
    var avatar: String?
    var sex: Int?
    var addr: String?
    var school: String?
    var className: String?
    var teacher: String?
    var remark: String?
    
    init(dict: [String: AnyObject]) {
        
        print("dict = \(dict)")
        
        
//        id = Int.init(dict["id"] as! String? ?? "0")!
//        mob = dict["mob"] as! String? ?? "暂无信息"
//        email = dict["email"] as! String? ?? "暂无信息"
//        access_token = dict["access_token"] as! String? ?? "暂无信息"
//        nick = dict["nick"] as! String? ?? "暂无信息"
//        type = dict["type"] as! String? ?? "暂无信息"
//        name = dict["name"] as! String? ?? "暂无信息"
//        avatar = dict["avatar"] as! String? ?? "暂无信息"
//        sex = Int.init(dict["sex"] as! String? ?? "0")!
//        addr = dict["addr"] as! String? ?? "暂无信息"
//        school = dict["school"] as! String? ?? "暂无信息"
//        className = dict["className"] as! String? ?? "暂无信息"
//        teacher = dict["teacher"] as! String? ?? "暂无信息"
//        remark = dict["remark"] as! String? ?? "暂无信息"
        
        id = Int.init((dict["id"] as? String? ?? "0")!)!
        mob = dict["mob"] as? String? ?? "暂无信息"
        email = dict["email"] as? String? ?? "暂无信息"
        access_token = dict["access_token"] as? String? ?? "暂无信息"
        nick = dict["nickname"] as? String? ?? "暂无信息"
        type = dict["type"] as? String? ?? "暂无信息"
        name = dict["name"] as? String? ?? "暂无信息"
        avatar = dict["avatar"] as? String? ?? "暂无信息"
        
        //将头像加入进去
        let Avatar = "Avatar"
//        UserDefaults.standard.object(forKey: Avatar)
        UserDefaults.standard.set(avatar, forKey: Avatar)
        
        sex = Int.init((dict["sex"] as? String? ?? "0")!)!
        addr = dict["addr"] as? String? ?? "暂无信息"
        school = dict["school"] as? String? ?? "暂无信息"
        className = dict["className"] as? String? ?? "暂无信息"
        teacher = dict["teacher"] as? String? ?? "暂无信息"
        remark = dict["remark"] as? String? ?? "暂无信息"
    }
    
    // 在对象归档的时候调用（哪些属性需要归档，怎么归档）
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(mob, forKey: "mob")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(nick, forKey: "nick")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(addr, forKey: "addr")
        aCoder.encode(school, forKey: "school")
        aCoder.encode(className, forKey: "className")
        aCoder.encode(teacher, forKey: "teacher")
        aCoder.encode(remark, forKey: "remark")
    }

    // 解析NIB/XIB的时候会调用
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
//        id = (aDecoder.decodeObject(forKey: "id") as? Int)!
        id = aDecoder.decodeObject(forKey: "id") as! Int? ?? 0
//        mob = (aDecoder.decodeObject(forKey: "mob") as? String)!
        mob = aDecoder.decodeObject(forKey: "mob") as! String? ?? "暂无信息"
//        email = (aDecoder.decodeObject(forKey: "email") as? String)!
        email = aDecoder.decodeObject(forKey: "email") as! String? ?? "暂无信息"
//        access_token = (aDecoder.decodeObject(forKey: "access_token") as? String)!
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String? ?? "暂无信息"
//        nick = (aDecoder.decodeObject(forKey: "nick") as? String)!
        nick = aDecoder.decodeObject(forKey: "nick") as! String? ?? "暂无信息"
//        type = (aDecoder.decodeObject(forKey: "type") as? String)!
        type = aDecoder.decodeObject(forKey: "type") as! String? ?? "暂无信息"
//        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        name = aDecoder.decodeObject(forKey: "name") as! String? ?? "暂无信息"
//        avatar = (aDecoder.decodeObject(forKey: "avatar") as? String)!
        avatar = aDecoder.decodeObject(forKey: "avatar") as! String? ?? "暂无信息"
//        sex = Int.init((aDecoder.decodeObject(forKey: "sex") as? String? ?? "0")!)
        sex = aDecoder.decodeObject(forKey: "sex") as! Int
//        addr = (aDecoder.decodeObject(forKey: "addr") as? String)!
        addr = aDecoder.decodeObject(forKey: "addr") as! String? ?? "暂无信息"
//        school = (aDecoder.decodeObject(forKey: "school") as? String)!
        school = aDecoder.decodeObject(forKey: "school") as! String? ?? "暂无信息"
//        className = (aDecoder.decodeObject(forKey: "className") as? String)!
        className = aDecoder.decodeObject(forKey: "className") as! String? ?? "暂无信息"
//        teacher = (aDecoder.decodeObject(forKey: "teacher") as? String)!
        teacher = aDecoder.decodeObject(forKey: "teacher") as! String? ?? "暂无信息"
//        remark = (aDecoder.decodeObject(forKey: "remark") as? String)!
        remark = aDecoder.decodeObject(forKey: "remark") as! String? ?? "暂无信息"
    }
    
    //在swift中,如果要实现description方法,需要遵守一个协议:Printable
    override var description:String {
//        let json = "{\"id\": \"\(id)\", \"mob\": \"\(mob)\", \"email\": \"\(email)\", \"nick\": \"\(nick)\",\"type\": \"\(type)\", \"name\": \"\(name)\", \"avatar\": \"\(avatar)\", \"addr\": \"\(addr)\", \"schoole\": \"\(school)\", \"className\": \"\(className)\", \"teacher\": \"\(teacher)\", \"remark\": \"\(remark)\"}"
        let json = "{\"sex\": \"\(sex!)\",\"email\": \"\(email!)\", \"nick\": \"\(nick!)\",\"type\": \"\(type!)\", \"name\": \"\(name!)\", \"addr\": \"\(addr!)\", \"school\": \"\(school!)\", \"class\": \"\(className!)\", \"teacher\": \"\(teacher!)\", \"remark\": \"\(remark!)\"}"
        return json
    }
    
}
