//
//  CustomCell.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/18.
//

import UIKit


protocol MobileDataUsageCellDelegate : NSObjectProtocol {
    func mobileDataUsageCellDidClickedImageView(cell: MobileDataUsageCell, year: String) -> Void
}

class MobileDataUsageCell : UITableViewCell {
    
    var timeLabel: UILabel?
    var dataLabel: UILabel?
    var descendImageView: UIImageView?
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
        timeLabel = UILabel.init(frame: CGRect(x:15, y:self.contentView.frame.height/2 - 18, width:200, height:17))
        timeLabel!.textColor = UIColor.black
        timeLabel!.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(timeLabel!)
        
        dataLabel = UILabel.init(frame: CGRect(x:15, y:self.contentView.frame.height/2 + 1, width:200, height:17))
        dataLabel!.textColor = UIColor.black
        dataLabel!.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(dataLabel!)
        
        descendImageView = UIImageView.init(frame: CGRect(x:self.contentView.frame.width - 30, y:self.contentView.frame.height/2 - 10, width:20, height:20))
        descendImageView?.isUserInteractionEnabled = true;
        descendImageView?.image = UIImage(named: "descend")
        contentView .addSubview(descendImageView!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MobileDataUsageCell.imageClickedAction(sender:)))
        descendImageView?.addGestureRecognizer(tap)
    }
    
    @objc func imageClickedAction(sender: UITapGestureRecognizer) -> Void {
        delegate?.mobileDataUsageCellDidClickedImageView(cell: self, year: self.year ?? "-")
    }
    
}
