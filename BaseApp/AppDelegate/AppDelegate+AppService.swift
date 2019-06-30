//
//  AppDelegate+AppService.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import UIKit
import Reachability
import SwiftyUserDefaults
extension AppDelegate: JPUSHRegisterDelegate {
    //MARK: 注册 第三方SDK
    func registThridSDK(launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        
    }
    
    //MARK: 设置极光推送
    func setUpJpush(launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        //Required
        //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            // Fallback on earlier versions
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        // Required
        // init Push
        // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
        var apsForProduction: Bool = false
        #if RELEASE
        apsForProduction = true
        #else
        apsForProduction = false
        #endif
        JPUSHService.setup(withOption: launchOptions, appKey: ThridPartyMarcos.JpushKey.rawValue, channel: "App Store", apsForProduction: apsForProduction, advertisingIdentifier: nil)
    }
    
    //MARK: 网络状态监控
    func setupNetworkNotification() {
        
        //实时监听网络链接状态
        hostReachability?.whenReachable = { reachability in
            trigger(.connected)
            if reachability.connection == .wifi {
                /// TODO……
                guard let lastStatus = Defaults[.kNetworkStatus] else {
                    return
                }
                if !lastStatus {
                    Defaults[.kNetworkStatus] = true
                    trigger(.connected)
                }
                
            } else if reachability.connection == .cellular  {
                /// TODO……
                guard let lastStatus = Defaults[.kNetworkStatus] else {
                    return
                }
                if !lastStatus {
                    Defaults[.kNetworkStatus] = true
                    trigger(.connected)
                }
                
            } else {
                Defaults[.kNetworkStatus] = false
                trigger(.unreachable)
                /// TODO……
                
            }
        }
        hostReachability?.whenUnreachable = { _ in
            Defaults[.kNetworkStatus] = false
            trigger(.unreachable)
            /// TODO……
            
        }
        
        do {
            try hostReachability?.startNotifier()
        } catch {
            /// print("Unable to start notifier")
        }
    }
}

