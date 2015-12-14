//
//  SetViewCell.swift
//  Note
//
//  Created by D_ttang on 15/12/11.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SetViewCell: UITableViewCell {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    // ["icon":"", "name": "默认文件名：", "action": ".txt"],
    var cellInfo: [String: AnyObject]? {
        didSet {
            setUpCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectedBackgroundView = UIView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell() {
        iconLabel.font = UIFont(name: "googleicon", size: 15)
        iconLabel.textColor = UIColor.MKColor.LightBlue
        iconLabel.text = cellInfo!["icon"] as? String
        
        nameLabel.text = cellInfo!["name"] as? String
        actionButton.setTitle(cellInfo!["action"] as? String, forState: UIControlState.Normal)
        
    }

    @IBAction func setCell(sender: AnyObject) {
        
    }
}
