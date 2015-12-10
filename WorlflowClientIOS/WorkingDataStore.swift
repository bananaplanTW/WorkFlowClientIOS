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

    
    private final let BASE_URL:String = "http://10.1.1.70:3000"
    private final class END_POINTS {
        static let EMPLOYEE_TASKS = "/api/employee/tasks"
    }
    
    private init() {
//        wipTask = Task(id: "asf", name: "管理1", caseName: "nicloud 專案管理")
        scheduledTaskList = [Task(id: "asf", name: "管理2", caseName: "nicloud 專案管理"),
                             Task(id: "asf", name: "管理3", caseName: "nicloud 專案管理"),
                             Task(id: "asf", name: "管理4", caseName: "nicloud 專案管理")];
    }

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
            print("ya")
            if error == nil && data != nil {
                print("success")
                print(data)

                let parsedData: AnyObject?
                do {
                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print(parsedData!)
                } catch {
                    parsedData = nil
                }
                
            } else {
                print(error)
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

}