//
//  CustomCell.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/18.
//

import UIKit
import SnapKit

protocol MobileDataUsageCellDelegate : NSObjectProtocol {
    func mobileDataUsageCellDidClickedImageView(cell: MobileDataUsageCell, year: String) -> Void
}

class MobileDataUsageCell : UITableViewCell {
    
    var timeLabel: UILabel!
    var dataLabel: UILabel!
    var descendImageView: UIImageView!
    var year: String?
    
    weak var delegate: MobileDataUsageCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.setUpUI()
    }
    
    func setUpUI() {
        timeLabel = UILabel.init()
        timeLabel.textColor = UIColor.black
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(timeLabel)
        timeLabel .snp_makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp_centerY).offset(-3)
            make.left.equalTo(self.contentView).offset(15)
        }
        
        dataLabel = UILabel.init()
        dataLabel.textColor = UIColor.black
        dataLabel.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(dataLabel)
        dataLabel .snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp_centerY).offset(3)
            make.left.equalTo(self.contentView).offset(15)
        }
        
        descendImageView = UIImageView.init()
        descendImageView.isUserInteractionEnabled = true;
        descendImageView.image = UIImage(named: "descend")
        contentView .addSubview(descendImageView)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MobileDataUsageCell.imageClickedAction(sender:)))
        descendImageView.addGestureRecognizer(tap)
        descendImageView .snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
        }
    }
    
    @objc func imageClickedAction(sender: UITapGestureRecognizer) -> Void {
        delegate?.mobileDataUsageCellDidClickedImageView(cell: self, year: self.year ?? "-")
    }
    
}
