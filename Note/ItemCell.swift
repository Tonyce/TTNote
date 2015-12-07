//
//  ItemCell.swift
//  Note
//
//  Created by D_ttang on 15/12/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isDir: Bool?
    var title: String?
    var documentUrl: NSURL?
    
    var itemInfo: [String: AnyObject]? {
        didSet {
            setUpCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell() {
        guard let itemInfo = itemInfo else {
            return
        }
        iconLabel.font = UIFont(name: "googleicon", size: 25)
        iconLabel.textColor = UIColor.MKColor.LightBlue
        let itemType = itemInfo["NSFileType"] as? String
        let itemName = itemInfo["NSFileName"] as? String
        nameLabel.text = itemName
        if itemType == "NSFileTypeRegular" {
            iconLabel.text = GoogleIcon.e985
        }else {
            iconLabel.text = GoogleIcon.e9c3
            self.accessoryType = .DisclosureIndicator
            self.isDir = true
        }
        
        let date = itemInfo["NSFileModificationDate"] as? NSDate
        self.timeLabel.text = date!.getTimeStrWithFormate()
        let size = itemInfo["NSFileSize"] as? Double
        self.sizeLabel.text = "\(String(format:"%.3f", size! / 1024)) KB"
        
        self.title = itemName
        self.documentUrl = itemInfo["documentUrl"] as? NSURL
    }
}

//    ["NSFileSystemFileNumber": 91669279, "NSFileExtensionHidden": 0, "NSFileModificationDate": 2015-12-07 11:41:09 +0000, "NSFileGroupOwnerAccountID": 20, "NSFileName": test.txt, "NSFileOwnerAccountID": 502, "NSFileSize": 0, "NSFileCreationDate": 2015-12-07 11:41:09 +0000, "NSFileSystemNumber": 16777221, "NSFilePosixPermissions": 420, "NSFileReferenceCount": 1, "NSFileGroupOwnerAccountName": staff, "NSFileType": NSFileTypeRegular]