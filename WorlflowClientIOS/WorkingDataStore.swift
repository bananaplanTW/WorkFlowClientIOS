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
    
    static let ACTION_LOAD_EMPLOYEE_COMPLETE = "actionLoadEmployeeComplete"
    static let ACTION_LOAD_EMPLOYEE_ICON_COMPLETE = "actionLoadEmployeeIconComplete"
    static let ACTION_LOAD_EMPLOYEE_FAIL = "actionLoadEmployeeFail"
    static let ACTION_SHOULD_RELOAD_EMPLOYEE = "actionShouldReloadEmployee"
    static let ACTION_SHOULD_RELOAD_EMPLOYEE_ICON = "actionShouldReloadEmployeeIcon"
    static let ACTION_CANCEL_RELOAD_TASKS = "actionCancelReloadEmployee"

    static let ACTION_EMPLOYEE_CHECK_IN_OUT = "actionEmployeeCheckInOut"

    static let ACTION_LOAD_EMPLOYEE_TASKS_COMPLETE = "actionLoadEmployeeTasksComplete"
    static let ACTION_LOAD_EMPLOYEE_TASKS_FAIL = "actionLoadEmployeeTasksFail"
    static let ACTION_SHOULD_RELOAD_EMPLOYEE_TASKS = "actionUpdateEmployeeTasks"
    static let ACTION_CANCEL_RELOAD_EMPLOYEE_TASKS = "actionCancelUpdateEmployeeTasks"

    static let ACTION_SHIFTED_TASK = "actionShiftedTask"
    static let ACTION_SUSPENDED_TASK = "actionSuspendedTask"
    static let ACTION_COMPLETED_TASK = "actionCompletedTask"

    private init() {}

    private var wipTask: Task?
    private var scheduledTaskList: Array<Task> = []

    private var employee: Employee?
    private var authToken:String = "Vx-i8Cgxdr5Mk_-mdL0HXJC9dkXfj50-vWO9oA3gEtv"
    private var userId: String = "pwcfTg448eeGafZWY"
    
    
    func getUserId () -> String {
        return userId
    }
    func getAuthToken () -> String {
        return authToken
    }
    func getEmployee () -> Employee? {
        return employee
    }
    
    
    func getTaskByTaskId (taskId: String) -> Task? {
        if wipTask?.id == taskId {
            return wipTask
        } else {
            return scheduledTaskList.filter({$0.id == taskId}).first
        }
    }
    func getWipTask () -> Task? {
        return wipTask
    }
    func getScheduledTaskList () -> Array<Task> {
        return scheduledTaskList
    }

    
    func syncTasks () {
        let headers:Dictionary = [
            "x-auth-token": authToken,
            "x-user-id": userId
        ]
        let queries: Dictionary = [
            "employeeId": userId
        ]
        let urlString: String = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.EMPLOYEE_TASKS, queries: queries)

        RestfulUtils.get(urlString, headers: headers) {
            (response: NSURLResponse!, data: NSData?, error: NSError!) -> Void in
            if error == nil && data != nil {
                let parsedData: AnyObject?
                do {

                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)

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
    
    
    func syncSelf () {
        let headers:Dictionary = [
            "x-auth-token": authToken,
            "x-user-id": userId
        ]
        
        let urlString: String = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.SELF, queries: nil)

        RestfulUtils.get(urlString, headers: headers) {
            (response: NSURLResponse!, data: NSData?, error: NSError!) -> Void in
            if error == nil && data != nil {
                let parsedData: AnyObject?
                do {
                    parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    if let response = parsedData as? NSDictionary {
                        if response["status"] as! String == "success" {
                            self.parseSelfData(response["result"] as! NSDictionary)
                        }
                    }
                    
                } catch {
                    parsedData = nil
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_COMPLETE, object: nil)
                
            } else {
                print(error)
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_FAIL, object: nil)
            }
        }
    }
    private func parseSelfData (parsedData: NSDictionary) {
        employee = Employee.createEmployee(parsedData)
    }

}