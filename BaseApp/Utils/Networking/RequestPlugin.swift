//
// Created by 张奇 on 2018/6/25.
// Copyright (c) 2018 Beijing Lingdaoyi Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import Result

enum ResponseCodeType: Int {
    case timeout                = 401    /// 请求超时
    case noneAuthentication     = 403    /// 未授权
    case accessTokenTimeout     = 426    /// token time out
}

/// 超时时长
private var requestTimeOut:Double = 30
//MARK: endpointClosure
let APIManagerEndpointClosure = { (target: APIManager) -> Endpoint in
    ///这里的endpointClosure和网上其他实现有些不太一样。
    ///主要是为了解决URL带有？无法请求正确的链接地址的bug
    let url = target.baseURL.absoluteString + target.path
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    switch target {
    case .login:
        return endpoint
    case .register:
        requestTimeOut = 5//按照项目需求针对单个API设置不同的超时时长
        return endpoint
    default:
        requestTimeOut = 30//设置默认的超时时长
        return endpoint
    }
}


/*
/// show or hide the loading hud
public final class RequestLoadingPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        /// show loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = true       /// 显示状态栏网络请求小菊花
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // hide loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = false      /// 隐藏状态栏网络请求小菊花
//        switch result {
//        case .success(let response):
//            let status: Int = response.statusCode
//            if 401 == status {      /// 超时
//                cowCloudRefreshAccessTokenModel.shared.refreshAccessToken()
//            } else if 426 == status {   ///  需要重新授权
//                MBProgressHUD.showError("请重新登录")
//            }
//            log.info("response.request = \(response.request!)")
//            //log.info("response.response = \(response.response!)")
//        case .failure(let error):
//            log.error("error = \(error)")
//            break
//
//        }
    }
    
}
 */

/*
class RequestLoadingPlugin: PluginType {
    
    var HUD:MBProgressHUD = MBProgressHUD()
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("开始请求")
        
        if let keyViewController = UIApplication.shared.keyWindow?.rootViewController {
            
            HUD.mode = MBProgressHUDMode.indeterminate
            HUD.bezelView.color = UIColor.lightGray
            HUD.removeFromSuperViewOnHide = true
            HUD.backgroundView.style = .solidColor
            HUD = MBProgressHUD.showAdded(to: keyViewController.view, animated: true)
            
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("结束请求")
        HUD.hide(animated: true, afterDelay: 0)
        
        guard case Result.failure(_) = result else {
            return
        }
        /// 请求失败
        let errorReason: String = (result.error?.errorDescription)!
        print("请求失败: \(errorReason)")
        /// 没网 "The Internet connection appears to be offline."
        /// 连接不到服务器 "Could not connect to the server."
        var tip = "请求失败!"
        if errorReason.contains("The Internet connection appears to be offline") {
            tip = "网络不给力,请检查您的网络"
        }
        if errorReason.contains("Could not connect to the server") {
            tip = "无法连接服务器"
        }
        /// 使用tip文字 进行提示
    }
}
*/

//MARK: 打印网络请求
public let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


// network logger
public final class NetworkLogger: PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {}
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let response):        /// case .success(let response):
            print("\ncurrent request URL: \(response.request!)  \n request Status: Request Successful!!!")
            break
        case .failure(let error):
            print(error)
            break
            
        }
        #endif
    }
}

/// AccessTokenPlugin
public final class AccessTokenPlugin: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let authorizable = target as? AccessTokenAuthorizable else {
            return request
        }
        var request = request
        switch authorizable.authorizationType {
        case .basic:
            request.addValue("Basic eHVlYmFPTFN0dWRlbnQ6YWlsZHk2NjY=", forHTTPHeaderField: "Authorization")
        case .bearer:
            /// add Basic header  - OAuth2 需要对数据进行重新认证
            let bearerValue: String  = UserDefaults.standard.string(forKey: "kAccessToken") ?? "5ab927f3-f181-47ff-9501-d0314123123c55"
            request.addValue("Bearer \(bearerValue)", forHTTPHeaderField: "Authorization")
        case .none:
            break;
        case .custom(_):
            break;
        }
        return request
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    
    init (configuration: URLSessionConfiguration, inMemoryCapacity: Int, diskCapacity: Int, diskPath: String?) {
        configuration.urlCache = URLCache(memoryCapacity: inMemoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}
