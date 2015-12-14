//
//  Employee.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/14/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

enum WorkingStatus: String {
    case OFF = "off"
    case PENDING = "pending"
    case WIP = "wip"
    case PAUSE = "pause"
    case STOP = "stop"
}

class Employee: User {
    let status: WorkingStatus
    var timecard: Timecard?
    var thumb: UIImage?

    init (id: String, name: String, iconPath: String?, status: WorkingStatus) {
        self.status = status
        super.init(id: id, name: name, iconPath: iconPath)
        
        if let path = iconPath {
            GetAPI.getImage(path) { (data, response, error) in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    self.thumb = UIImage(data: data)

                    NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_ICON_COMPLETE, object: nil)
                }
            }
        }
    }
    
    
    class func createEmployee (attributes: NSDictionary) -> Employee {
        let employee = Employee(
            id: attributes["_id"] as! String,
            name: attributes["profile"]!["name"] as! String,
            iconPath: attributes["iconThumbUrl"] as? String,
            status: WorkingStatus.init(rawValue: attributes["status"] as! String)!
        )
        if let timecardAttr:NSDictionary = attributes["timecard"] as? NSDictionary {
            employee.timecard = Timecard.createTimecard(timecardAttr)
        }
        return employee
    }
}