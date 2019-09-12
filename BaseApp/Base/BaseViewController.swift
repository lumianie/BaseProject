//
//  BaseViewController.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit

enum TransitionType {
    case push
    case present
}

class BaseViewController: UIViewController {
    
    var transitionType: TransitionType {
        get {
            if (self.presentingViewController != nil) && self.navigationController!.viewControllers.count == 1 {
                return .present
            } else {
                return .push
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.ViewBackgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            //scrollerView在导航栏透明时不下压
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
        }
        // Do any additional setup after loading the view.
        if transitionType == .push {
            let image = R.image.backBtn()
            let closeItem = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeItemClick))
            self.navigationItem.leftBarButtonItem = closeItem;
        } else {
            let image = R.image.dismissBtn()
            let dismissItem = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeItemClick))
            self.navigationItem.leftBarButtonItem = dismissItem
        }
    }

    //返回
    @objc func closeItemClick() {
        switch transitionType {
            case .push:
                self.rt_navigationController.popViewController(animated: true)
            case .present:
                self.dismiss(animated: true, completion: nil)
        }
    }
    //设置导航栏图片
    func setUpNavigationBarBackgroundImage() {
        let image = R.image.navigationBarBg()?.resizableImage(withCapInsets: UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
        self.rt_navigationController.navigationBar.setBackgroundImage(image, for: .default)
    }
    //设置navigation title
    func navigationTitle(title: String, color: UIColor, font: UIFont) {
        self.title = title
        self.rt_navigationController.navigationBar.setTitleFont(font, color: color)
    }
}
