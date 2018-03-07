//
//  Dispatch.swift
//  Example
//
//  Created by Davide Mendolia on 23/11/15.
//  Copyright © 2015 GoKarumi S.L. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON
//import JLToast

let HOMEBASEURL = "http://shuoke360.cn/api/copybook/?token=gstshuoke360"

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
    )
}
/*
1、http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=1&type=yuedu&pid=411

type=yuedu   pid= 411      每日推荐
type=beitie  pid=""        碑帖
type=note    pid= ""       课程讲义
type=yuedu   pid= 413      书法世界
type=yuedu   pid= 414      文房雅趣
type=yuedu   pid= 412      名家名作

{
    "success":true,
    "error_code":0,
    "message":"数据加载完毕",
    "data":[
    {
    "id":"1115",
    "title":"广东“女子书法十家”作品展佛山开幕",
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


2、阅读（yuedu）类详情：
http://shuoke360.cn/api/copybook?token=gstshuoke360&type=yuedu&pid=411&id=1115
动态传入相应的：pid;  和id

3、碑帖详情
http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=0&id=1223&type=beitie
动态传入:id

4、讲义详情
https://view.officeapps.live.com/op/view.aspx?src="+url
url = video

{
    "success":true,
    "error_code":0,
    "message":"数据加载完毕",
    "data":[
    {
    "id":"1190",
    "diyname":"",
    "title":"赵体概述",
    "title2":null,
    "content":"",
    "pid":"436",
    "font":"0",
    "keywords":"",
    "description":"",
    "istop":"0",
    "status":"1",
    "img_url":"",
    "img_url_s":null,
    "sort":"0",
    "dateline":"1503113558",
    "video":"/Public/Uploads/Note/20170819/5997b13f814c1.ppt",
    "hits":"0",
    "view_count":"0"
    }
    ]
}
 */

func getHomeCommonData(type: String, pid: Int,page:Int,finished:@escaping (_ items: [Common]) -> ()) {
    let url = HOMEBASEURL
    let params: [String: Any]?
    if type != "yuedu" {
        params = ["type": type,"page":page]
    }else{
        params = ["type": type,"pid":pid,"page":page]
    }
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
        if let value = response.result.value {
            let dict = JSON(value)
            if dict["data"].arrayObject != nil{
                let data = dict["data"].arrayObject
                debugPrint("data:",data?.count)
                var results = [Common]()
                for item in data!{
                    let itemDict = item as! NSDictionary
                    
                    let id = itemDict.value(forKey: "id") as! String
                    let title = itemDict.value(forKey: "title") as! String
                    var img_url_s_str = ""
                    if let img_url_s = itemDict.value(forKey: "img_url_s") as? String {
                        img_url_s_str = img_url_s 
                    }else{
                        img_url_s_str = ""
                    }
                    var video_str = ""
                    if let video = itemDict.value(forKey: "video") as? String {
                        video_str = video
                    }else{
                        video_str = ""
                    }
                    let view_count = itemDict.value(forKey: "view_count") as! String
                    
                    let result = Common(id: id, title: title, img_url_s: img_url_s_str, view_count: Int(view_count)!, video: video_str)
                    results.append(result)
                }
                finished(results)
            }
            else{
                debugPrint("暂无内容")
            }
            
        }
    }

}

/*
 http://shuoke360.cn/api/video?token=gstshuoke360&jiegou=559&bianpang=458&bihua=431&class=619&page=1
 */
func getVideoData(jiegou: Int = 0, bianpang: Int = 0, bihua:Int = 0, class1:Int = 0,page: Int = 1, finished: @escaping (_ items: [Video]) -> ()){
    let url = BASEURL + "api/video?token=gstshuoke360"
    let params: [String: Any] = ["jiegou": jiegou,"bianpang":bianpang,"bihua":bihua,"class": class1, "page":page]
    
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
        if let value = response.result.value {
            let dict = JSON(value)
            if dict["data"].arrayObject != nil{
                let data = dict["data"].arrayObject
                debugPrint("data:",data?.count)
                var results = [Video]()
                for item in data!{
                    let itemDict = item as! NSDictionary
                    
                    let name = itemDict.value(forKey: "name") as! String
                    let img_url = itemDict.value(forKey: "img_url") as! String
                    let img_url_s = itemDict.value(forKey: "img_url_s") as! String
                    let video_url = itemDict.value(forKey: "video_url") as! String
                    
                    let result = Video(name: name, img_url: img_url, img_url_s: img_url_s, video_url: video_url)
                    results.append(result)
                }
                finished(results)
            }
            else{
                debugPrint("暂无内容")
            }
            
        }
    }
}

/*
 3、碑帖详情
 http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=0&id=1223&type=beitie
 动态传入:id
 */
func getCopyBookDetailData(type: String, id: String,page:Int,finished:@escaping (_ items: [CopyBookDetail]) -> ()){
    let url = BASEURL + "api/copybook/?token=gstshuoke360"
    let params: [String: Any] = ["type": type,"id":id,"page":page]
    
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
        if let value = response.result.value {
            let dict = JSON(value)
            if dict["data"].arrayObject != nil{
                let data = dict["data"].arrayObject
                debugPrint("data:",data?.count)
                var results = [CopyBookDetail]()
                for item in data!{
                    let itemDict = item as! NSDictionary
                    
                    var img_url_str = ""
                    if let img_url = itemDict.value(forKey: "img_url") as? String {
                        img_url_str = img_url
                    }else{
                        img_url_str = ""
                    }
                    let result = CopyBookDetail(img_url: img_url_str)
                    results.append(result)
                }
                finished(results)
            }
            else{
                debugPrint("暂无内容")
            }
            
        }
    }
}

/*
 登录
 http://shuoke360.cn/api/login?token=gstshuoke360&mob=modi@163.com&password=123
 */
func login(mob: String, password: String, finished:@escaping (_ item: LoginUser) -> ()){
    let url = BASEURL + "api/login?token=gstshuoke360"
    let params: [String: Any] = ["mob": mob,"password": password]
    
//    Alamofire
//        .request(.GET, url)
//        .responseJSON { (response) in
//            guard response.result.isSuccess else {
//                SVProgressHUD.showErrorWithStatus("加载失败...")
//                return
//            }
//            if let value = response.result.value {
//                let dict = JSON(value)
//                let code = dict["code"].intValue
//                let message = dict["message"].stringValue
//                guard code == RETURN_OK else {
//                    SVProgressHUD.showInfoWithStatus(message)
//                    return
//                }
//                SVProgressHUD.dismiss()
//                if let data = dict["data"].dictionaryObject {
//                    let productDetail = YMProductDetail(dict: data)
//                    finished(productDetail: productDetail)
//                }
//            }
//    }
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        guard response.result.isSuccess else {
            SVProgressHUD.showError(withStatus: "网络连接异常，登录失败...")
            return
        }
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            if let data = dict["data"].dictionaryObject {
                let loginUser = LoginUser(dict: data as [String : AnyObject])
                finished(loginUser)
            }
        }
    }
}
/*
 登录
 http://shuoke360.cn/api/login?token=gstshuoke360&mob=modi@163.com&password=123
 */
func autoLogin(token: String, finished:@escaping (_ item: LoginUser) -> ()){
    let url = BASEURL + "api/auto_login?token=gstshuoke360"
    let params: [String: Any] = ["access_token": token]

    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        guard response.result.isSuccess else {
            SVProgressHUD.showError(withStatus: "自动登录失败...")
            return
        }
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: "自动登录失败请重新登录 ~")
                return
            }
            SVProgressHUD.dismiss()
            if let data = dict["data"].dictionaryObject {
                let loginUser = LoginUser(dict: data as [String : AnyObject])
                finished(loginUser)
            }
        }
    }
}

/*
 保存修改后的数据
 http://shuoke360.cn/api/update?token=gstshuoke360&access_token=21600wb6c1620146w23s5f1lblwqs02b&data={"name":"仿佛大","nickname":"58商城","sex":"1"}
 */
func updateUserInfo(loginUser: LoginUser){
    let url = BASEURL + "api/update?token=gstshuoke360"
    let json = JSON.init(parseJSON: loginUser.description)
    debugPrint("json = \(json)")
    let params: [String: Any] = ["access_token": loginUser.access_token!,
                                 "data": json]
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        
        if response.result.isSuccess {
            let value = response.result.value
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            //显示时间过长
            SVProgressHUD.showSuccess(withStatus: message)
        }
    }
}


/*
 {
 "success": true,
 "error_code": 0,
 "message": "上传成功",
 "data": {
 "img_url": "\/Public\/Uploads\/avatar\/20170914\/14.jpeg"
 }
 }
 头像上传
 http://shuoke360.cn/api/avatar?token=gstshuoke360&access_token=gj1tjo85h71j09dcjd11fmem797bo0cc&img=base64
 */
func getUserAvatar(token: String,data: String, finished:@escaping (_ path: String) -> ()){
    let url = BASEURL + "api/avatar?token=gstshuoke360"
    let params: [String: Any] = ["img": data,
                                 "access_token": token]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        debugPrint("json = \(response.result.value)")
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            
            if let data = dict["data"].dictionaryObject {
                let path = data["img_url"] as? String
                finished(path!)
            }
        }
    }
}
/*
 {
 "success":true,
 "error_code":0,
 "message":"修改成功",
 "data":{
 "error_code":0
 }
 }
 修改密码
 http://shuoke360.cn/api/setpwd?token=gstshuoke360&access_token=21600wb6c1620146w23s5f1lblwqs02b&oldpwd=123456&newpwd=1234561
 */
func updatePassword(token: String,oldpwd: String, newpwd: String, finished:@escaping (_ rs: Bool) -> ()){
    let url = BASEURL + "api/setpwd?token=gstshuoke360"
    let params: [String: Any] = ["oldpwd": oldpwd,
                                 "access_token": token,
                                 "newpwd": newpwd]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        debugPrint("json = \(response.result.value)")
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            return finished(true)
        }
    }
}

/*
 {
 "success":false,
 "error_code":1,
 "message":"手机号已存在",
 "data":{
 "error_code":1
 }
 }
 提交注册
 http://shuoke360.cn/api/register?token=gstshuoke360&mob=13528605866&pass=123456
 */
func submitRegitser(mob: String,pwd: String, finished:@escaping (_ rs: Bool) -> ()){
    let url = BASEURL + "api/register?token=gstshuoke360"
    let params: [String: Any] = ["mob": mob,
                                 "pass": pwd]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        debugPrint("json = \(response.result.value)")
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            return finished(true)
        }
    }
}

/*
 {
 "success":false,
 "error_code":1,
 "message":"新密码不能和原密码一样",
 "data":{
 "error_code":1
 }
 }
 找回密码
 http://shuoke360.cn/api/findpwd?token=gstshuoke360&mob=13528605866&pass=123456
 */
func forgotPassword(mob: String,pwd: String, finished:@escaping (_ rs: Bool) -> ()){
    let url = BASEURL + "api/findpwd?token=gstshuoke360"
    let params: [String: Any] = ["mob": mob,
                                 "pass": pwd]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        debugPrint("json = \(response.result.value)")
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            return finished(true)
        }
    }
}

/*
 {
 "success":true,
 "error_code":0,
 "message":"数据加载完毕",
 "data":[
 {
 "id":"380",
 "member_id":"1",
 "name":"孩子怎样才能写一手好字？",
 "model":"read",
 "dateline":"1498264831"
 },
 {
 "id":"381",
 "member_id":"1",
 "name":"曹全碑",
 "model":"beitie",
 "dateline":"1498264876"
 }
 ]
 }
 
 浏览记录
 http://shuoke360.cn/api/history?token=gstshuoke360&access_token=91bh4u9a56h98rh330kbav0s4u84a798&page=1
 */
func getRecord(token: String,page: Int, finished:@escaping (_ records: [Record]) -> ()) {
    let url = BASEURL + "api/history?token=gstshuoke360"
    let params: [String: Any] = ["access_token": token,
                                 "page": page]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
            guard code == RETURN_OK else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            SVProgressHUD.dismiss()
            
            var records = [Record]()
            if let data = dict["data"].arrayObject {
                for item in data {
                    let itemDict = JSON(item)
                    let model = itemDict["model"].stringValue
                    if (model != "peixun"){
                        records.append(Record(dict: item as! [String : Any]))
                    }
                    
                }
            }
            return finished(records)
        }
    }
}

/*
 下载文件
 */
func downloadFile(path: String,name: String, finished:@escaping (_ result: (String,Double)) -> ()) {
    let url = path
    var filePath1 = ""
    var pro = 0.0
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(name + ".ppt")
        
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
//    let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    Alamofire.download(url, to: destination).response { response in
        debugPrint(response)
        let filePath = response.destinationURL?.path
        if !(filePath?.isEmpty)! {
            filePath1 = filePath!
            debugPrint("filePath: \(filePath)")
            if UserServece.checkFileExist(fileName: filePath!) {
                SVProgressHUD.showInfo(withStatus: "文件已经存在~")
                return finished((filePath1,pro))
            }else{
                if response.error == nil {
                    return finished((filePath1,pro))
                }
            }
        }
        }.downloadProgress { progress in
//            debugPrint("Progress: \(progress.fractionCompleted)")
            pro = progress.fractionCompleted
            return finished((filePath1,pro))
    }
}

//获取本地下载列表
func getDownloadFiles(finished:@escaping (_ result: ([Download],String)) -> ()) {
    var result = [Download]()
    let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
    debugPrint("docment ＝ \(basePath)")
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: basePath!){
        let childrenPath = fileManager.subpaths(atPath: basePath!)
        for childPathin in childrenPath!{
            //过滤登录信息缓存路径
            if childPathin.contains(".ppt") {
//                let filePath = basePath?.appending("/").appending(childPathin)
//                debugPrint("ppt Ptah = \(filePath)")
                result.append(Download(path: childPathin))
            }
        }
    }
    return finished((result,basePath!))
}

func getSearchResults(searchText: String, page: Int = 1, finished:@escaping (_ results: ([SearchModel])) -> ()) {
    let url = BASEURL + "api/search?token=gstshuoke360"
    let params: [String: Any] = ["key": searchText,
                                 "page": page]
    
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        if let value = response.result.value {
            let dict = JSON(value)
            let code = dict["error_code"].intValue
            let message = dict["message"].stringValue
//            guard code == RETURN_OK else {
//                SVProgressHUD.showInfo(withStatus: message)
//                return
//            }
            SVProgressHUD.dismiss()
            var result = [SearchModel]()
            if let data = dict["data"].arrayObject {
                for item in data {
                    let itemDict = JSON(item)
                    let model = itemDict["model"].stringValue
                    if itemDict != nil {
                        result.append(SearchModel(dict: item as! [String : Any]))
                    }
                }
            }
            return finished(result)
        }
    }
}
