//
//  AppDelegate+Push.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
extension AppDelegate {
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        log.error("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    //iOS7之后,点击消息进入APP
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Required, iOS 7 Support
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        self.dealWithUserInfo(userInfo: userInfo as NSDictionary as! [String: AnyObject])
    }
    
    //iOS7之前
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Required, For systems with less than or equal to iOS 6
        JPUSHService.handleRemoteNotification(userInfo)
    }
}

extension AppDelegate {
    @available(iOS 10.0, *)
    //前台收到推送, 如果用户关闭推送，APP在前台也会收到（走极光自定义消息）
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo as! [String: Any]
        
    }
    
    @available(iOS 10.0, *)
    //后台收到推送点击进入app
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        //对应跳转页面
        let userInfo = response.notification.request.content.userInfo as! [String:Any]
        JPUSHService.handleRemoteNotification(userInfo)
        
        self.dealWithUserInfo(userInfo: userInfo)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
    }
    
    func dealWithUserInfo(userInfo: [String: Any]) {
        
    }
}
