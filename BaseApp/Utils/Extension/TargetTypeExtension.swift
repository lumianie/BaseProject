//
//  TargetTypeExtension.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import Moya

/// key
public extension TargetType {
    
    var cacheKey: String {
        
        let urlStr = baseURL.appendingPathComponent(path).absoluteString
        var sortParams = ""
        var parameter: [String: Any]?
        do{
            let json = try JSONSerialization.jsonObject(with: sampleData, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            parameter = dic
        } catch _ { return urlStr }
        
        guard let params = parameter else {
            return urlStr
        }
        /// sort
        let sortArr = params.keys.sorted { (str1, str2) -> Bool in
            return str1 < str2
        }
        for str1 in sortArr {
            if let value = params[str1] {
                sortParams = sortParams.appending("\(str1)=\(value)")
            }
        }
        return urlStr.appending("?\(sortParams)/\(appVersion!)/\(appBuildVersion!)")
    }
}
