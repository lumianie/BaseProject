//
//  TodayHistoryModel.swift
//  BaseApp
//
//  Created by Lee on 2019/9/10.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import ObjectMapper

struct TodayHistoryResponse: Mappable {
    var error_code: Int = 0
    var reason: String = ""
    var result: [TodayHistoryModel]?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        error_code   <-   map["error_code"]
        reason       <-   map["reason"]
        result       <-   map["result"]
    }
}

struct TodayHistoryModel: Mappable {
    
    
    var day: Int = 0
    var des: String = ""
    var id: Int = 0
    var lunar: String = ""
    var month: Int = 0
    var pic: String = ""
    var title: String = ""
    var year: Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        day    <-    map["day"]
        des    <-    map["des"]
        id     <-    map["id"]
        lunar  <-    map["lunar"]
        month  <-    map["month"]
        pic    <-    map["pic"]
        title  <-    map["title"]
        year   <-    map["year"]
        
    }
}
