//
//  TodayHistoryViewController.swift
//  BaseApp
//
//  Created by Lee on 2019/9/10.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TodayHistoryViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kUIScreenWidth, height: kUIScreenHeight - kUINavigationBarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.registerCell(cellTypes: [TodayHistoryCell.self])
        return tableView
    }()
    
    var modelArray: [TodayHistoryModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        
        viewModel.todayHistory(param: ["key": "a3ac2fa6d2f63640e7f7fd229cc1a8f6", "v": "1.0", "month": Date().month, "day": Date().day], success: { (response) in
            self.modelArray = response.result
            kLog(message: response)
        }) { (error) in
            kLog(message: error)
        }
        
    }
    
}

extension TodayHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TodayHistoryCell.self)
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    
}
