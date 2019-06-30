//
//  FirstLaunch.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class FirstLaunch {
    
    internal static let shared = FirstLaunch()
    private init() {}
    
    /// func is first launch
    func isFirstLaunch() {
        guard let firstLaunch = Defaults[.kFirstLaunch] else { return }
        if firstLaunch {
            Defaults[.kEverLaunch] = true
            Defaults[.kFirstLaunch] = false
        } else {
            Defaults[.kFirstLaunch] = true
            Defaults[.kEverLaunch] = true
        }
    }
    
    /// get is first launch
    func getIsFirstLaunch() -> Bool {
        guard let firstLaunch = Defaults[.kFirstLaunch] else { return false }
        return firstLaunch
    }
    
}
