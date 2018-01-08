//
//  NetworkTools.swift
//  AiDuoBao
//
//  Created by Hanson on 9/2/17.
//  Copyright © 2017 Hanson. All rights reserved.
//

import Foundation
import Alamofire

public enum RequestMethod {
    case GET
    case POST
}


class NetworkTools: NSObject {

    var baseURL: String = "http://ip:port/api/"
    var baseParams: Parameters = [:]
    static let manager = NetworkTools()
    
    // MARK: - private function
    
    @discardableResult
    private func request(
        _ url: String,
        method: RequestMethod = .GET,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?)
        -> DataRequest {
            
            // 获取完整URL
            let completeUrl = getCompleteUrl(url)
            // 拼接全局参数
            let completeParams = combinationParameters(parameters)
            // 请求方式
            let requestMethod = getRequqstMethod(method)
            return Alamofire.request(completeUrl,
                                     method: requestMethod,
                                     parameters: completeParams,
                                     encoding: JSONEncoding(options: []),
                                     headers: headers)
    }
    
    private func getRequqstMethod(_ method: RequestMethod) -> HTTPMethod {
        switch method {
        case .POST:
            return .post
        case .GET:
            return .get
        }
    }
    
    private func getCompleteUrl(_ url: String) -> String {
        return baseURL + url
    }
    
    private func combinationParameters(_ parameters: Parameters?) -> Parameters {
        
        var params: Parameters = Parameters()
//        params["sid"] = ".."
        if var parameters = parameters {
            for (key, value) in baseParams {
                parameters[key] = value
            }
            params["data"] = parameters
        } else {
           params["data"] = baseParams
        }
        return params
    }
}

// MARK: - GET / POST Method

extension NetworkTools {
    
//    @discardableResult
//    class func GET(
//        _ url: String,
//        parameters: Parameters? = nil)
//        -> DataRequest {
//            return NetworkTools.manager.request(url, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
//    }
//    
//    @discardableResult
//    class func POST(
//        _ url: String,
//        parameters: Parameters? = nil)
//        -> DataRequest {
//            return NetworkTools.manager.request(url, method: .POST, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
//    }
    
}
