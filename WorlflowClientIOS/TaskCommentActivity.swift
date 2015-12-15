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
        let activity = TaskCommentActivity(
            id:        attributes["_id"] as! String,
            ownerName: attributes["ownerName"] as! String,
            createdAt: NSDate(timeIntervalSince1970: NSTimeInterval(secs)),
            type:      .TASK_COMMENT,
            comment:   attributes["content"] as! String
        )
        if let path:String = attributes["iconThumbUrl"] as? String {
            GetAPI.getImage(path) { (data, response, error) in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    activity.iconThumb = UIImage(data: data)
                }
            }
        }
        return activity
    }
    class func createTaskCommentActivityLocally (comment: String, ownerName: String, iconThumb: UIImage?) -> Activity {
        let activity = TaskCommentActivity(
            id:        "",
            ownerName: ownerName,
            createdAt: NSDate(),
            type:      .TASK_COMMENT,
            comment:   comment
        )
        activity.iconThumb = iconThumb
        return activity
    }
}