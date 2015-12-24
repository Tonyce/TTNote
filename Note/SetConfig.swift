//
//  SystemConfig.swift
//  superman
//
//  Created by D_ttang on 15/7/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class SetConfig: NSObject {
    
    let filemgr = NSFileManager.defaultManager()
    var setConfigData: NSMutableDictionary?
    
//    let colorArr = Colors.colorArr
//    let defaultColorEntry = Colors.colorArr[0]
//    let defaultSettingEntrys = [ ["img":GoogleIcon.ec29 , "word":"建议及意见", "href":"http://haosou.com", "colorIndex": 0] ]
////    let defaultSettingEntrys = [ ["img": "\u{ec29}" , "word":"建议及意见", "href":"http://youku.com", "colorIndex": 0] ]
//    
////    var userName: String?
////    var lastLoginTime: Int?
    var defaultFileName: String = "yy-MM-dd"
    var defaultFormat: String = ".md" // .txt
    var isFristOpen: Bool = true
    
    class var sharedInstance: SetConfig {
        struct Singleton {
            static let instance = SetConfig()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
        setConfigData = readSystemConfig()
        
        if let setConfigData = setConfigData {
            if let fileName = setConfigData["defaultFileName"] as? String {
                defaultFileName = fileName
            }
            
            if let format = setConfigData["defaultFormat"] as? String {
                defaultFormat = format
            }
            
            if let isFrist = setConfigData["isFirstOpen"] as? Bool {
                isFristOpen = isFrist
            }
        }
    }
    
    func saveSystemConfig(key: String, value: AnyObject){
        
        guard let filename = self.filePath("setConfig.plist") else {
            return
        }
        var data: NSMutableDictionary
        
        if let fileData = NSMutableDictionary(contentsOfFile: filename as String) {
            data = fileData
        }else {
            data = NSMutableDictionary()
        }
        data.setObject(value, forKey: key)
        data.writeToFile(filename, atomically: true)
    }
    
    func readSystemConfig() -> NSMutableDictionary?{
        
        guard let filename = self.filePath("setConfig.plist") else {
            return nil
        }
        if filemgr.fileExistsAtPath(filename) {
            let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile: filename as String)!
            return data
        }
        return nil
    }
    
    func filePath(filename: String) -> String? {

        let mypaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.ApplicationSupportDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let appSupportDir = mypaths[0]
        
        var isDirectory = ObjCBool(true)
        if filemgr.fileExistsAtPath(appSupportDir, isDirectory: &isDirectory) == false {
            if isDirectory.boolValue == true {
                do {
                    try filemgr.createDirectoryAtPath(appSupportDir, withIntermediateDirectories: true, attributes: nil)
                }catch _ {
                    return nil
                }
            }
        }
        // print(appSupportDir)
        let filepath = (appSupportDir as NSString).stringByAppendingPathComponent(filename as String)
        return filepath
    }
}
