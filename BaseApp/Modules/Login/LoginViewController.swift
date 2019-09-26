//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        LoginViewModel().userLogin(param: ["username": "xx", "password": "xxxxxxx"], success: { (response) in
            
        }) { (error) in
            
        }
        
    }
    

    

}
