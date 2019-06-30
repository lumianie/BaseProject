//
//  UIScreen+Extension.swift
//  perpetualCalendar
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen {
    /// The screen size
    class var ol_size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// The screen bounds
    class var ol_bounds: CGRect {
        return UIScreen.main.bounds
    }
    
    /// The screen's width
    class var ol_width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// The screen's height
    class var ol_height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// The screen's orientation size
    @available(iOS 8.0, *)
    class var ol_orientationSize: CGSize {
        guard UIApplication.shared != nil else {
            return CGSize.zero
        }
        let systemVersion = (UIDevice.current.systemVersion as NSString).floatValue
        //  let isLand: Bool = UIInterfaceOrientationIsLandscape(app.statusBarOrientation)
        let isLand: Bool = UIInterfaceOrientation.landscapeLeft.isLandscape
        return (systemVersion > 8.0 && isLand) ? UIScreen.ol_swapSize(self.ol_size) : self.ol_size
    }
    
    /// The screen's orientation width
    class var ol_orientationWidth: CGFloat {
        return self.ol_orientationSize.width
    }
    
    /// The screen's orientation height
    class var ol_orientationHeight: CGFloat {
        return self.ol_orientationSize.height
    }
    
    /// The screen's DPI size
    class var ol_DPISize: CGSize {
        let size: CGSize = UIScreen.main.bounds.size
        let scale: CGFloat = UIScreen.main.scale
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    /**
     Swap size
     
     - parameter size: The target size
     
     - returns: CGSize
     */
    class func ol_swapSize(_ size: CGSize) -> CGSize {
        return CGSize(width: size.height, height: size.width)
    }
    
    /// The screen's height without status bar's height
    @available(iOS 8.0, *)
    class var ol_screenHeightWithoutStatusBar: CGFloat {
        let app = UIApplication.shared
        let isLand: Bool = UIInterfaceOrientation.landscapeLeft.isLandscape
        if isLand {
            return UIScreen.main.bounds.size.height - app.statusBarFrame.height
        } else {
            return UIScreen.main.bounds.size.width - app.statusBarFrame.height
        }
    }
}
