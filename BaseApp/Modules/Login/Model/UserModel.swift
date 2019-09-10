//
//  UserModel.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyUserDefaults

struct UserModel: Mappable, DefaultsSerializable, Codable {
    static var _defaults: DefaultsBridge<UserModel> { return DefaultsCodableBridge() }
    
    static var _defaultsArray: DefaultsBridge<[UserModel]> { return DefaultsCodableBridge() }
    
    typealias T = UserModel
    
    
    var id: Int = 0
    var username: String = ""
    var password: String = ""
    var token: String = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id         <-   map["id"]
        username   <-   map["username"]
        password   <-   map["password"]
        token      <-   map["token"]
    }
}
