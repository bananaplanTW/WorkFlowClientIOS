//
//  WorkingDataStore.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class WorkingDataStore {
    class func sharedInstance () -> WorkingDataStore {
        struct Static {
            static let instance: WorkingDataStore = WorkingDataStore()
        }
        return Static.instance
    }

    static let ACTION_LOAD_EMPLOYEE_TASKS_COMPLETE = "actionLoadEmployeeTasksComplete"
    static let ACTION_LOAD_EMPLOYEE_TASKS_FAIL = "actionLoadEmployeeTasksFail"
    
    static let ACTION_UPDATE_EMPLOYEE_TASKS = "actionUpdateEmployeeTasks"
    static let ACTION_CANCEL_UPDATE_EMPLOYEE_TASKS = "actionCancelUpdateEmployeeTasks"
    
    private final let BASE_URL:String = "http://10.1.1.55:3000"
    private final class END_POINTS {
        static let EMPLOYEE_TASKS = "/api/employee/tasks"
    }
    
    private init() {}

    private var wipTask: Task?
    private var scheduledTaskList: Array<Task> = []
    private var authToken:String = "adjzyrbxHsyGZeaQV2kvq2SOWS71HlYFF5K1YOwi-b9"
    private var userId: String = "QNXpzjCQhiqYpGJdD"
    
    
    func syncTasks () {
        // sync task data from server
        let headers:Dictionary = [
            "x-auth-token": authToken,
            "x-user-id": userId
        ]
        let queries: Dictionary = [
            "employeeId": userId
        ]
        let urlString: String = URLUtils.buildURLString(BASE_URL, endPoint: END_POINTS.EMPLOYEE_TASKS, queries: queries)

        RestfulUtils.get(urlString, headers: headers) {
            (response: NSURLResponse!, data: NSData?, error: NSError!) -> Void in
            if error == nil && data != nil {
                let parsedData: AnyObject?
                do {

                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print(parsedData)
                    
                    if let response = parsedData as? NSDictionary {
                        if response["status"] as! String == "success" {
                            self.parsePersonalTasks(response["result"] as! NSDictionary)
                        }
                    }
                    
                } catch {
                    parsedData = nil
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_TASKS_COMPLETE, object: nil)
                
            } else {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_TASKS_FAIL, object: nil)
            }
        }
        print(urlString)
    }


    func getWipTask () -> Task? {
        return wipTask
    }
    func getScheduledTaskList () -> Array<Task> {
        return scheduledTaskList
    }
    
    
    private func parsePersonalTasks (parsedData: NSDictionary) {
        wipTask = nil
        if let _wipTask = parsedData["WIPTask"] as? NSDictionary {
            wipTask = Task.createTask(_wipTask)
        }

        scheduledTaskList = []
        if let _scheduledTasks = parsedData["scheduledTasks"] as? NSArray {
            for task in _scheduledTasks {
                scheduledTaskList.append(Task.createTask(task as! NSDictionary))
            }
        }
        print("tasks")
        print(wipTask)
        print(scheduledTaskList)
    }

}