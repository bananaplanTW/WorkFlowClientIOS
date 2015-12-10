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

    private init() {
//        wipTask = Task(id: "asf", name: "管理1", caseName: "nicloud 專案管理")
        scheduledTaskList = [Task(id: "asf", name: "管理2", caseName: "nicloud 專案管理"),
                             Task(id: "asf", name: "管理3", caseName: "nicloud 專案管理"),
                             Task(id: "asf", name: "管理4", caseName: "nicloud 專案管理")];
    }

    private var wipTask: Task?
    private var scheduledTaskList: Array<Task> = []
    
    
    func syncTasks () {
        // sync task data from server
    }


    func getWipTask () -> Task? {
        return wipTask
    }
    func getScheduledTaskList () -> Array<Task> {
        return scheduledTaskList
    }

}