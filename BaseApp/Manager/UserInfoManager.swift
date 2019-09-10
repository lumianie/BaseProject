//
//  UserInfoManager.swift
//  BaseApp
//
//  Created by Lee on 2019/9/10.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class UserInfoManager {
    internal static let shared = UserInfoManager()
    private init() {}
    
    var userModel: UserModel? = UserModel()
    
    //保存用户信息
    func saveUserInfoWithModel(_ model: UserModel) {
        userModel?.id = model.id
        userModel?.username = model.username
        userModel?.password = model.password
        userModel?.token = model.token
        
        Defaults[.kUserModel] = userModel
        
    }
    
    //是否登录
    func isUserAlreadyLogin() -> Bool {
        if Defaults[.kUserModel] != nil {
            return true
        }
        return false
    }
    
    
    //清空用户信息
    func clearUserInfo() {
        if Defaults[.kUserModel] != nil {
            Defaults[.kUserModel] = nil
        }
    }
}
