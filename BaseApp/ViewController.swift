//
//  ViewController.swift
//  BaseApp
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit
import Moya

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func next(_ sender: Any) {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
}

