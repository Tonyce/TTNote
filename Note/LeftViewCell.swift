//
//  LeftViewCell.swift
//  Note
//
//  Created by D_ttang on 15/12/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class LeftViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    
    var cellInfo: [String: AnyObject]? {
        didSet {
            if cellInfo != nil {
                setUpCell()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell() {
        iconLabel.font = UIFont(name: "googleicon", size: 18)
        iconLabel.textColor = UIColor.MKColor.LightBlue
        
        nameLabel.text = cellInfo!["name"] as? String
        iconLabel.text = cellInfo!["icon"] as? String
    }

}
