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
    var thumb: UIImage?

    init(id: String, ownerName: String, createdAt: NSDate, type: ActivityType, photoPath: String, thumbPath: String?) {
        self.photoPath = photoPath
        self.thumbPath = thumbPath

        super.init(id: id, ownerName: ownerName, createdAt: createdAt, type: type)
        
        if let path = thumbPath {
            GetAPI.getImage(path) { (data, response, error) in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    self.thumb = UIImage(data: data)
                }
            }
        }
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