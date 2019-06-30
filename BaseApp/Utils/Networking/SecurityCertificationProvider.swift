//
//  SecurityCertificationProvider.swift
//  xuebaOL
//
//  Created by 张奇 on 2018/10/1.
//  Copyright © 2018 Beijing Lingdaoyi Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import Alamofire


class SecurityCertificationProvider {
    
    internal static let shared = SecurityCertificationProvider()
    private init() {}
    /// https头部信息的provider
    static func manager() -> Manager {
        //使用Alamofire的直接使用manager做请求
        let manager: Alamofire.SessionManager = {
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 10 // timeout
            configuration.httpMaximumConnectionsPerHost = 50
            let manager = Alamofire.SessionManager(configuration: configuration)
            manager.adapter = CustomRequestAdapter()
            
            manager.delegate.sessionDidReceiveChallenge = { session, challenge in
                var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
                var credential: URLCredential?
                
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                    disposition = URLSession.AuthChallengeDisposition.useCredential
                    credential = URLCredential(trust: challenge.protectionSpace.serverTrust! )
                } else {
                    if challenge.previousFailureCount > 0 {
                        disposition = .cancelAuthenticationChallenge
                    } else {
                        credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                        
                        if credential != nil {
                            disposition = .useCredential
                        }
                    }
                }
                return (disposition, credential)
            }
            return manager
        }()
        return manager
    }
    
    // request adpater to add default http header parameter
    private class CustomRequestAdapter: RequestAdapter {
        public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            urlRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            return urlRequest
        }
    }

}
