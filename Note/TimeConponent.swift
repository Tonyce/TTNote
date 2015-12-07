//
//  TimeConponent.swift
//  NoSingle
//
//  Created by D_ttang on 15/11/19.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation

extension NSDate {
    class func getTimeStrWithFormate(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        // Date 转 String
        let nowString = dateFormatter.stringFromDate(now)
        return nowString
    }
    
    func getTimeStrWithFormate(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        // Date 转 String
        let nowString = dateFormatter.stringFromDate(self)
        return nowString
    }
    
    class func convertRFC3339DateTimeToString(rfc3339DateTime: String?) -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

        if rfc3339DateTime != nil {
            let date = dateFormatter.dateFromString(rfc3339DateTime!)
            return date
        }
        return nil

//        var userVisibleDateTimeString: String!
//        let userVisibleDateFormatter = NSDateFormatter()
//        userVisibleDateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
//        userVisibleDateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        userVisibleDateTimeString = userVisibleDateFormatter.stringFromDate(date!)
    }
    
    struct Date {
        static let formatter = NSDateFormatter()
    }
    var formatted: String {
        Date.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        Date.formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        Date.formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        Date.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return Date.formatter.stringFromDate(self)
    }
    // NSDate().formatted
}