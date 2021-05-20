//
//  CustomCell.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/18.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var timeLabel : UILabel?
    var dataLabel : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.setUpUI()
    }
    
    func setUpUI() {
        timeLabel = UILabel.init(frame: CGRect(x:15, y:self.contentView.frame.height/2 - 18, width:100, height:17))
        timeLabel!.textColor = UIColor.black
        timeLabel!.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(timeLabel!)
        
        dataLabel = UILabel.init(frame: CGRect(x:15, y:self.contentView.frame.height/2 + 1, width:100, height:17))
        dataLabel!.textColor = UIColor.black
        dataLabel!.font = UIFont.systemFont(ofSize: 16)
        contentView .addSubview(dataLabel!)
    }
    
    
}
