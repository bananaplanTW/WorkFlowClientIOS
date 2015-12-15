//
//  APIs.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class APIs {
    static let BASE_URL:String = "http://10.1.1.61:3000"
    class END_POINTS {
        static let EMPLOYEE_TASKS = "/api/employee/tasks"
        static let TASK_ACTIVITIES = "/api/task/activities"
        static let ADD_TEXT_TASK_ACTIVITY = "/api/add-task-activity/text"
        static let SELF = "/api/self"
        static let CHECK_IN_OUT = "/api/checkin-out/employee"
    }
}