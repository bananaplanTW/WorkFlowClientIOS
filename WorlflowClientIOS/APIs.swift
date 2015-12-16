//
//  APIs.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class APIs {
    static let BASE_URL:String = "http://52.26.71.101"
    class END_POINTS {
        static let EMPLOYEE_TASKS = "/api/employee/tasks"
        static let TASK_ACTIVITIES = "/api/task/activities"
        static let ADD_TEXT_TASK_ACTIVITY = "/api/add-task-activity/text"
        static let ADD_IMAGE_TASK_ACTIVITY = "/api/add-task-activity/image"
        static let SELF = "/api/self"
        static let CHECK_IN_OUT = "/api/checkin-out/employee"
        static let SHIFT_TASK = "/api/v2/shift-task"
        static let SUSPEND_TASK = "/api/v2/suspend-task"
        static let COMPLETE_TASK = "/api/v2/complete-task"
        static let LOGIN = "/api/login"
        static let CEHCK_TASK_TODO = "/api/v2/check-task-todo"
    }
}