//
//  UrlMarcos.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation

public var BaseUrl: String {
    #if DEBUG
    return "http://devapi"                      //开发环境
    #elseif TEST
    return "http://testapi"                     //测试环境
    #elseif PRERELEASE
    return "http://preapi"                      //预发环境
    #elseif RELEASE
    return "http://prodev"                      //生产环境
    #endif
}
