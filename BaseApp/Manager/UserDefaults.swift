//
//  UserDefaults.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let kNetworkStatus = DefaultsKey<Bool?>("kNetworkStatus", defaultValue: true)
    static let kFirstLaunch = DefaultsKey<Bool?>("kFirstLaunch", defaultValue: false)
    static let kEverLaunch = DefaultsKey<Bool?>("kEverLaunch", defaultValue: true)
}
