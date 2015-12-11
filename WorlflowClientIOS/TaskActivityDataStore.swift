//
//  TaskActivityDataStore.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class TaskActivityDataStore {
    class func sharedInstance () -> TaskActivityDataStore {
        struct Static {
            static let instance: TaskActivityDataStore = TaskActivityDataStore()
        }
        return Static.instance
    }
}