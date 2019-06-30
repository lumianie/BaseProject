//
//  UserModel.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    
    var username: String = ""
    var password: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        username   <-   map["username"]
        password   <-   map["password"]
    }
}
