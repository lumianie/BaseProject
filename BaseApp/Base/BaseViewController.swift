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
    
    
    //导航栏右按钮（图片）
    lazy var rightButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        return btn
    }()
    //导航栏右按钮（文字）
    lazy var rightTextButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        btn.titleLabel?.text = "nextPage"
        btn.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        return btn
    }()

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
    }

    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        return UIBarButtonItem(image: R.image.backBtn(), style: .plain, target: self, action: #selector(back))
    }

    //返回
    @objc func back() {
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
    //设置右按钮（图片）
    func setUpRightNavigationImageBtn() {
        let rightBarButton = UIBarButtonItem(customView: self.rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    //设置右按钮（文字）
    func setUpRightNavigationTextBtn() {
        let rightBarButton = UIBarButtonItem(customView: self.rightTextButton)
        self.navigationItem.rightBarButtonItems = [self.getNavigationSpacerWithSpacer(spacer: 0), rightBarButton]
    }
    //设置导航栏左右按钮的偏移距离
    func getNavigationSpacerWithSpacer(spacer: CGFloat) -> UIBarButtonItem {
        let navgationButtonSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        navgationButtonSpacer.width = spacer
        return navgationButtonSpacer
    }
    //设置navigation title
    func navigationTitle(title: String, color: UIColor, font: UIFont) {
        self.title = title
        self.rt_navigationController.navigationBar.setTitleFont(font, color: color)
    }
    //点击导航栏右侧按钮
    @objc func rightBtnClicked() {
        
    }
}
