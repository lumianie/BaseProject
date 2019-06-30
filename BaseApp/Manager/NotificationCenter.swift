//
//  NotificationCenter.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
extension Notification.Name {
    /// 网络已连接
    public static let connected: NSNotification.Name = Notification.Name("connectedEvent")
    /// 网络不可用
    public static let unreachable: NSNotification.Name = Notification.Name("unreachableEvent")
}
