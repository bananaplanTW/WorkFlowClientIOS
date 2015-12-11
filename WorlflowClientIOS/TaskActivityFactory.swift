//
//  TaskActivityFactory.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskActivityFactory {
    class func createTaskActivity (taskActivityAttributes: NSDictionary) -> Activity? {
        switch taskActivityAttributes["type"] as! String {
        case "comment":
            return TaskCommentActivity.createTaskCommentActivity(taskActivityAttributes)
        case "attachment":
            if taskActivityAttributes["contentType"] as! String == "file" {
                return TaskFileActivity.createTaskFileActivity(taskActivityAttributes)
            } else if taskActivityAttributes["contentType"] as! String == "image" {
                return TaskPhotoActivity.createTaskPhotoActivity(taskActivityAttributes)
            }
            break;
        default:
            break;
        }
        return nil
    }
}