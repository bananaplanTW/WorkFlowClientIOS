//
//  TaskFileActivity.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskFileActivity: Activity {
    let filePath: String!
    let fileName: String!
    
    init(id: String, ownerName: String, createdAt: NSDate, type: ActivityType, filePath: String, fileName: String) {
        self.filePath = filePath
        self.fileName = fileName
        
        super.init(id: id, ownerName: ownerName, createdAt: createdAt, type: type)
    }
    
    class func createTaskFileActivity (attributes: NSDictionary) -> Activity {
        let secs = (attributes["createdAt"] as! Int) / 1000
        return TaskFileActivity(
            id:        attributes["_id"] as! String,
            ownerName: attributes["ownerName"] as! String,
            createdAt: NSDate(timeIntervalSince1970: NSTimeInterval(secs)),
            type:      .TASK_FILE,
            filePath:  attributes["fileUrl"] as! String,
            fileName:  attributes["name"] as! String
        )
    }
}