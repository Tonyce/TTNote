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
    
    let filemgr = NSFileManager.defaultManager()
    
    var isDir: Bool?
    var fileType: String?
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
        iconLabel.font = UIFont(name: "myicomoon", size: 25)
        iconLabel.textColor = UIColor.MKColor.LightBlue
        let itemType = itemInfo["NSFileType"] as? String
        let itemName = itemInfo["NSFileName"] as? String
        self.documentUrl = itemInfo["documentUrl"] as? NSURL
        
        let size = itemInfo["NSFileSize"] as? Double
        self.sizeLabel.text = "\(String(format:"%.3f", size! / 1024)) KB"
        
        nameLabel.text = itemName
        if itemType == "NSFileTypeRegular" {
            if self.documentUrl?.pathExtension == "txt" {
                self.fileType = "txt"
                if size > 0 {
                    iconLabel.text = MyIcoMoon.e906
                }else {
                    iconLabel.text = MyIcoMoon.e905
                }

            }else if self.documentUrl?.pathExtension == "pdf" {
                self.fileType = "pdf"
                iconLabel.text = MyIcoMoon.e903
            }
        }else {
            var directoryContents = []
            do {
                directoryContents = try filemgr.contentsOfDirectoryAtURL(documentUrl!, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
            }catch _ {}
            if directoryContents.count > 0 {
                iconLabel.text = MyIcoMoon.e901
            }else {
                iconLabel.text = MyIcoMoon.e900
            }
            self.sizeLabel.text = "\(directoryContents.count) 文件"
            self.accessoryType = .DisclosureIndicator
            self.isDir = true
        }
        
        let date = itemInfo["NSFileModificationDate"] as? NSDate
        self.timeLabel.text = date!.getTimeStrWithFormate()

        
        self.title = itemName

    }
}

//    ["NSFileSystemFileNumber": 91669279, "NSFileExtensionHidden": 0, "NSFileModificationDate": 2015-12-07 11:41:09 +0000, "NSFileGroupOwnerAccountID": 20, "NSFileName": test.txt, "NSFileOwnerAccountID": 502, "NSFileSize": 0, "NSFileCreationDate": 2015-12-07 11:41:09 +0000, "NSFileSystemNumber": 16777221, "NSFilePosixPermissions": 420, "NSFileReferenceCount": 1, "NSFileGroupOwnerAccountName": staff, "NSFileType": NSFileTypeRegular]