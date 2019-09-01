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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tableView)
        tableView.register(cellWithClass: PickImageCell.self)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PickImageCell.self)
        cell.didUpdateFrame = { [weak self] frame in
            self?.tableView.reloadData()
        }
        return cell
    }
    
    
}
