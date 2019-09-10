//
//  TodayHistoryCell.swift
//  BaseApp
//
//  Created by Lee on 2019/9/10.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit
import SnapKit
import AutoInch

class TodayHistoryCell: UITableViewCell {
    var imgView: UIImageView = UIImageView()
    var contentLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TodayHistoryCell")
        imageView?.contentMode = .scaleAspectFill
        self.addSubview(imgView)
        contentLabel.numberOfLines = 0
        
        self.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.auto())
            make.bottom.right.equalToSuperview().offset(-10.auto())
            make.left.equalTo(imgView.snp.right).offset(10.auto())
        }
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10.auto())
            make.bottom.equalToSuperview().offset(-10.auto())
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100.auto())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var model: TodayHistoryModel? {
        didSet {
            imgView.sd_setImage(with: URL(string: model!.pic), completed: nil)
            contentLabel.text = model?.des
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
