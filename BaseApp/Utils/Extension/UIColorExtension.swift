//
//  UIColorExtension.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import SwifterSwift

extension UIColor {
    //页面背景色
    class var ViewBackgroundColor: UIColor {
        get {
            return UIColor.init(hexString: "FFFFFF")!
        }
    }
    //导航栏颜色
    class var NavigationBarColor: UIColor {
        get {
            return UIColor.init(hexString: "#54A6F9")!
        }
    }
    //tabbar选中的颜色
    class var tabbarSelectedTextColor: UIColor {
        get {
            return UIColor.init(hexString: "#007AFF")!
        }
    }
    //cell分割线颜色
    class var cellSepColor: UIColor {
        get {
            return UIColor.init(hexString: "#EEEEEE")!
        }
    }
    //其他背景颜色
    class var otherBackgroundColor: UIColor {
        get {
            return UIColor.init(hexString: "#E7EBEE")!
        }
    }
}
