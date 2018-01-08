//
//  CacheCommonService.swift
//  HandWriting
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import CoreData

class CacheCommonService {
    private struct CommonConstants {
        static let EntityName = "CacheCommon"
    }
    
    class func insertCommonWithArray(arr: [Common], type: Int) {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        if arr.count > 0 {
            for common in arr {
                if let com = selectCommonById(id: common.id) {
                    debugPrint("该数据已存在~~~")
                }else {
                    let cacheCommon = NSEntityDescription.insertNewObject(forEntityName: CommonConstants.EntityName, into: context) as! CacheCommon
                    cacheCommon.id = common.id
                    cacheCommon.title = common.title
                    cacheCommon.imgUrl = common.img_url_s
                    cacheCommon.video = common.video
                    cacheCommon.viewCount = Float(common.view_count)
                    cacheCommon.type = Int32(type)
                }
            }
        }
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
    
    class func selectCommonById(id: String) -> CacheCommon? {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = NSEntityDescription.entity(forEntityName: CommonConstants.EntityName, in: context)
        //指定条件查询request.predicate
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let match = try context.fetch(request) as! [CacheCommon]
            if match.count > 0 {
               return match[0]
            }
        }catch {
            debugPrint("error = \(error)")
        }
        return nil
    }
    
    class func selectCommons(page:Int, finished:@escaping (_ commons: [CacheCommon]) -> ()) {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.fetchLimit = 10
        request.fetchOffset = page * request.fetchLimit
        request.entity = NSEntityDescription.entity(forEntityName: CommonConstants.EntityName, in: context)
        //指定条件查询request.predicate
        //        request.predicate = NSPredicate(format: "unique = %@", "fdsafdafdsafds343rere" + String(4))
        do {
            let match = try context.fetch(request) as! [CacheCommon]
            if match.count > 0 {
                finished(match)
            }
        }catch {
            debugPrint("error = \(error)")
        }
    }
    
    class func selectCommonsByType(type: Int, page:Int, finished:@escaping (_ commons: [Common]) -> ()) {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.fetchLimit = 10
        request.fetchOffset = (page-1) * request.fetchLimit
        request.entity = NSEntityDescription.entity(forEntityName: CommonConstants.EntityName, in: context)
        //指定条件查询request.predicate
        request.predicate = NSPredicate(format: "type = %i", Int32(type))
        do {
            let match = try context.fetch(request) as! [CacheCommon]
            if match.count > 0 {
                //转换模型
                var commons = [Common]()
                for cCommon in match {
                    let common = mappingCacheCommonToCommon(cacheCommon: cCommon)
                    commons.append(common)
                }
                finished(commons)
            }
        }catch {
            debugPrint("error = \(error)")
        }
    }
    
    class func mappingCacheCommonToCommon(cacheCommon: CacheCommon) -> Common{
        let common = Common(id: cacheCommon.id!, title: cacheCommon.title!, img_url_s: cacheCommon.imgUrl!, view_count: Int(cacheCommon.viewCount), video: cacheCommon.video!)
        return common
    }
    
    //删除
    class func deleteCommonById(id: String) {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        if let common = selectCommonById(id: id) {
            let context = container.viewContext
            context.delete(common)
            do {
                //保存
                try context.save()
            }catch {
                print(error)
            }
        }
    }
    
    //修改
    class func updateCommon(common: Common) {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        if let comm = selectCommonById(id: common.id) {
            let context = container.viewContext
            comm.id = common.id
            comm.title = common.title
            comm.imgUrl = common.img_url_s
            comm.video = common.video
            comm.viewCount = Float(common.view_count)
            do {
                //保存
                try context.save()
            }catch {
                print(error)
            }
        }
    }
}
