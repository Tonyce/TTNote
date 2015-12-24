//
//  Application.swift
//  NoSingle
//
//  Created by D_ttang on 15/11/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func appName() -> String {
        // print(NSBundle.mainBundle().infoDictionary)
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
    }
    
    class func appVersion() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    }
    
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
        
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
}

extension UIDevice {
    
    class func phoneName() -> String {
        return UIDevice.currentDevice().name
    }

    class func phoneUniqueIdentifier() -> String? { //UUID,5.0后不可用
        // return UIDevice.currentDevice().uniqueIdentifier
        return nil
    }
    
    class func phoneSystemName() -> String {
        return UIDevice.currentDevice().systemName
    }
    
    class func phoneSystemVersion() -> String {
        return UIDevice.currentDevice().systemVersion
    }
    
    class func phoneModel() -> String { // 设备模式
        return UIDevice.currentDevice().model
    }
    
    class func phoneLocalModel() -> String { //本地设备模式
        return UIDevice.currentDevice().localizedModel
    }
    
    
    class func phoneNetworkType() -> (Int, String)? {
        let subViews = UIApplication.sharedApplication().valueForKey("statusBar")?.valueForKey("foregroundView")?.subviews
        
        var type: Int32?
        for subview in subViews! {
            if subview.isKindOfClass(NSClassFromString("UIStatusBarDataNetworkItemView")!) {
                type = subview.valueForKey("dataNetworkType")?.intValue
                //print(type)
            }
        }
        var networkType = ""
        guard let intType = type else {
            return nil
        }
        switch intType {
        case 0:
            networkType = "" //"No wifi or cellular"
            break;
            
        case 1:
            networkType = "2G"
            break;
            
        case 2:
            networkType = "3G"
            break;
            
        case 3:
            networkType = "4G"
            break;
            
        case 4:
            networkType = "LTE"
            break;
            
        case 5:
            networkType = "Wifi"
            break;
        default:
            break;
        }
        
        return (Int(intType), networkType)
    }
}

extension NSLocale {
    class func language() -> String {
        return NSLocale.preferredLanguages()[0]
    }
    
//    class func country() -> String { //国家
//        return NSLocale.currentLocale().localeIdentifier
//    }
}