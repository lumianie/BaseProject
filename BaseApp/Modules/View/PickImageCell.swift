//
//  PickImageCell.swift
//  BaseApp
//
//  Created by Lee on 2019/8/31.
//  Copyright © 2019 nielei. All rights reserved.
//

import UIKit
import SnapKit


let pickViewMarginLeft: Float = 10
let pickViewItemSpace: Float = 7
let pickViewRowCount: Int = 3

typealias frameUpdateCallback = (_ frame: CGRect) -> Void

class PickImageCell: UITableViewCell {
    
    //高度更新回调
    var didUpdateFrame: frameUpdateCallback?
    
    lazy var photoManage: HXPhotoManager = {
        let photoManage = HXPhotoManager(type: .photoAndVideo)
        let config = HXPhotoConfiguration()
        config.rowCount = UInt(pickViewRowCount)
        config.maxNum = 9
        config.saveSystemAblum = true
        config.restoreNavigationBar = true
        photoManage?.configuration = config
        return photoManage!
    }()
    
    lazy var photoView: HXPhotoView = {
       let photoView = HXPhotoView(manager: photoManage)
        photoView?.delegate = self
        photoView?.spacing = CGFloat(pickViewItemSpace)
        photoView?.edgeSpacing = 10
        photoView?.cellCornerRadius = 10
        photoView?.cellBackgroundColor = kHexColor("F1F3F4")
        return photoView!
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(self.photoView)
        photoView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(pickViewMarginLeft)
            make.right.equalTo(self).offset(-pickViewMarginLeft)
            make.top.bottom.equalToSuperview()
            let pickViewWidth = Float(kUIScreenWidth) - 2 * pickViewMarginLeft
            let itemWidth = (pickViewWidth - pickViewItemSpace * Float(pickViewRowCount - 1)) / Float(pickViewRowCount)
            make.height.equalTo(itemWidth)
        }
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension PickImageCell: HXPhotoViewDelegate {
    func photoListViewControllerDidDone(_ photoView: HXPhotoView!,
                                        allList: [HXPhotoModel]!,
                                        photos: [HXPhotoModel]!,
                                        videos: [HXPhotoModel]!,
                                        original isOriginal: Bool) {
        
    }
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        //更新frame
        kLog(message: frame)
        photoView.snp.updateConstraints { (make) in
            make.height.equalTo(frame.height)
        }
        self.didUpdateFrame?(frame)
    }
}
