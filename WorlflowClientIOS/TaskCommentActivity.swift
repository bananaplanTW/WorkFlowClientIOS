//
//  TaskCommentActivity.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskCommentActivity: Activity {
    let comment: String!
    init(id: String, ownerName: String, createdAt: NSDate, type: ActivityType, comment: String) {
        self.comment = comment

        super.init(id: id, ownerName: ownerName, createdAt: createdAt, type: type)
    }
    
    class func createTaskCommentActivity (attributes: NSDictionary) -> Activity {
        let secs = (attributes["createdAt"] as! Int) / 1000
        return TaskCommentActivity(
            id:        attributes["_id"] as! String,
            ownerName: attributes["ownerName"] as! String,
            createdAt: NSDate(timeIntervalSince1970: NSTimeInterval(secs)),
            type:      .TASK_COMMENT,
            comment:   attributes["content"] as! String
        )
    }
}