//
//  UITableView+registCell.swift
//  EarlyWeather
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 com.jerring.EarlyWeather. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    func registerCell(cellTypes:[AnyClass]){
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle.init(for: cellType).path(forResource: typeString, ofType: "nib")
            if xibPath==nil {
                self.register(cellType, forCellReuseIdentifier: typeString);
            }
            else{
                self.register(UINib.init(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
            }
        }
    }
}
