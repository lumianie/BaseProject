//
//  Observable+ObjectMapper.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
import AwesomeCache


var openRequestLog = true
let cache = try! Cache<Caccc>(name: "AwesomeCache")

//MARK: - request & cache
extension MoyaProvider {
    /// json
    open func requestJson(_ token: Target, isCache: Bool = false) -> RxSwift.Observable<Any> {
        return sb_request(token, isCache: isCache)
            .filterSuccessfulStatusCodes()
            .mapJSON()
    }
    
    /// string
    open func requestString(_ token: Target, isCache: Bool = false) -> RxSwift.Observable<String> {
        return sb_request(token, isCache: isCache)
            .filterSuccessfulStatusCodes()
            .mapString()
    }
    
    func sb_request(_ token: Target, isCache: Bool = false) -> Observable<Response> {
        
        
        return Observable.create { observer in
            let key = token.cacheKey
            
            //每次请求网络前先从本地读取缓存显示出来，网络请求成功后再更新数据
            
            
            // request
            let cancellableToken = self.request(token) { result in
                
                switch result {
                case let .success(response):
                    /// save memory
                    if isCache == true && response.statusCode >= 200 && response.statusCode <= 299 {
                        let cacheObj = Caccc.init(statusCode: response.statusCode, data: response.data, request: response.request, response: response.response)
                        cache[key] = cacheObj
                    }
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    if  isCache == true, let res = cache[key] {
                        if res.statusCode >= 200 && res.statusCode <= 299 {
                            let response = Response.init(statusCode: res.statusCode, data: res.data, request: res.request, response: (res.response as! HTTPURLResponse))
                            observer.onNext(response)
                        }
                    }
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}


extension Observable {
    func mapObject<T: Mappable>(type: T.Type, key: String? = nil) -> Observable<T> {
        return self.map { response in
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            if let k = key {
                guard let dictionary = dict[k] as? [String: Any] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                return Mapper<T>().map(JSON: dictionary)!
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type, key: String? = nil) -> Observable<[T]> {
        return self.map { response in
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            if key != nil {
                guard let dictionary = dict[key!] as? [[String: Any]] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                return Mapper<T>().mapArray(JSONArray: dictionary)
            } else {
                guard let array = response as? [Any] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                guard let dicts = array as? [[String: Any]] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                return Mapper<T>().mapArray(JSONArray: dicts)
            }
        }
    }
    
    func parseServerError() -> Observable {
        return self.map { (response) in
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                
                throw error
            }
            return self as! Element
        }
        
    }
    
    fileprivate func parseError(response: [String: Any]?) -> NSError? {
        var error: NSError?
        if let value = response {
            /// ⚠️在获取errors的错误码时，需根据当期后端对接错误码字段定义描述相对应，否则会出现异常空数据的情形
            if let code = value["code"] as? Int, code != 0 {
                var msg = ""
                /// ⚠️在获取errors的数据描述时，需根据当期后端对接错误描述相对应，否则会出现异常空数据的情形
                if let message = value["msg"] as? String {
                    msg = message
                }
                error = NSError(domain: "Network", code: code, userInfo: [NSLocalizedDescriptionKey: msg])
            }
        }
        return error
    }
    
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {}
