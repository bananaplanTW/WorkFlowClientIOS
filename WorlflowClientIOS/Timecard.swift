//
//  Timecard.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/14/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

enum TimecardStatus: String {
    case OPEN = "open"
    case CLOSE = "close"
}

class Timecard {
    let startDate: NSDate!
    let endDate: NSDate!
    let status: TimecardStatus!
    init (startDate: NSDate, endDate: NSDate, status: TimecardStatus) {
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
    
    class func createTimecard(attributes: NSDictionary) -> Timecard {
        let startDateSecs = (attributes["startDate"] as! Int) / 1000
        let endDateSecs = (attributes["endDate"] as! Int) / 1000
        
        let timecard = Timecard(
            startDate: NSDate(timeIntervalSince1970: NSTimeInterval(startDateSecs)),
            endDate: NSDate(timeIntervalSince1970: NSTimeInterval(endDateSecs)),
            status: TimecardStatus.init(rawValue: attributes["status"] as! String)!
        )
        return timecard
    }
}