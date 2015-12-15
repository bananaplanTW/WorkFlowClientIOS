//
//  TaskActivityDataStore.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskActivityDataStore {
    static let ACTION_LOAD_TASK_ACTIVITIES_COMPLETE: String = "actionLoadTaskActivitiesComplete"
    static let ACTION_LOAD_TASK_ACTIVITIES_FAIL: String = "actionLoadTaskActivitiesFail"

    static let ACTION_SENT_MESSAGE_TO_TASK: String = "actionSentMessageToTask"
    static let ACTION_SENT_PHOTO_TO_TASK: String = "actionSentPhotoToTask"

    static let ACTION_SHOULD_RELOAD_TASK_ACTIVITIES: String = "ACTION_SHOULD_RELOAD_TASK_ACTIVITIES"

    class func sharedInstance () -> TaskActivityDataStore {
        struct Static {
            static let instance: TaskActivityDataStore = TaskActivityDataStore()
        }
        return Static.instance
    }
    
    private var taskActivityMap: Dictionary<String, Array<Activity>> = [:]

    func getTaskActivitiesByTaskId (taskId: String) -> Array<Activity> {
        if let activities = taskActivityMap[taskId] {
            return activities
        }
        return []
    }
    func addTaskCommentActivityToTask (taskId: String, comment: String, ownerName: String, iconThumb: UIImage?) {
        let activity = TaskCommentActivity.createTaskCommentActivityLocally(comment, ownerName: ownerName, iconThumb: iconThumb)
        taskActivityMap[taskId]?.insert(activity, atIndex: 0)
    }
    func addTaskPhotoActivityToTask (taskId: String, photo: UIImage, ownerName: String, iconThumb: UIImage?) {
        let activity = TaskPhotoActivity.createTaskPhotoActivityLocally(photo, ownerName: ownerName, iconThumb: iconThumb)
        taskActivityMap[taskId]?.insert(activity, atIndex: 0)
    }
    

    func syncTaskActivities(taskId: String) {
        let instance: WorkingDataStore = WorkingDataStore.sharedInstance()
        let headers:Dictionary = [
            "x-auth-token": instance.getAuthToken(),
            "x-user-id": instance.getUserId()
        ]
        let queries: Dictionary = [
            "taskId": taskId
        ]

        let urlString: String = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.TASK_ACTIVITIES, queries: queries)
        
        RestfulUtils.get(urlString, headers: headers) {
            (response: NSURLResponse!, data: NSData?, error: NSError!) -> Void in
            if error == nil && data != nil {
                let parsedData: AnyObject?
                do {
                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)

                    if let response = parsedData as? NSDictionary {
                        if response["status"] as! String == "success" {
                            self.parseTaskActivities(response["result"] as! Array, taskId: taskId)
                        }
                    }
                    
                } catch {
                    parsedData = nil
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(TaskActivityDataStore.ACTION_LOAD_TASK_ACTIVITIES_COMPLETE, object: nil)
                
            } else {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName(TaskActivityDataStore.ACTION_LOAD_TASK_ACTIVITIES_FAIL, object: nil)
            }
        }
    }
    
    func parseTaskActivities (result: Array<NSDictionary>, taskId: String) {
        var taskActivities: Array<Activity> = []
        for taskActivityAttributes: NSDictionary in result {
            if let activity = TaskActivityFactory.createTaskActivity(taskActivityAttributes) {
                taskActivities.append(activity)
            }
        }
        taskActivityMap[taskId] = taskActivities
    }
}