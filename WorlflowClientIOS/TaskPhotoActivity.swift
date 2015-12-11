//
//  TaskPhotoActivity.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskPhotoActivity: Activity {
    let photoPath: String!
    let thumbPath: String?

    init(id: String, ownerName: String, createdAt: NSDate, type: ActivityType, photoPath: String, thumbPath: String?) {
        self.photoPath = photoPath
        self.thumbPath = thumbPath

        super.init(id: id, ownerName: ownerName, createdAt: createdAt, type: type)
    }
    
    class func createTaskPhotoActivity (attributes: NSDictionary) -> Activity {
        let secs = (attributes["createdAt"] as! Int) / 1000
        return TaskPhotoActivity(
            id:         attributes["_id"] as! String,
            ownerName:  attributes["ownerName"] as! String,
            createdAt:  NSDate(timeIntervalSince1970: NSTimeInterval(secs)),
            type:       .TASK_PHOTO,
            photoPath:  attributes["imageUrl"] as! String,
            thumbPath:  attributes["thumbUrl"] as? String
        )
    }
}