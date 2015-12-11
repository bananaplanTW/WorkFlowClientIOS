//
//  Activity.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

enum ActivityType {
    case TASK_COMMENT
    case TASK_PHOTO
    case TASK_FILE
}

class Activity {
    let id: String!
    let ownerName: String!
    let createdAt: NSDate!
    let type: ActivityType!
    init (id: String, ownerName: String, createdAt: NSDate, type: ActivityType) {
        self.id = id
        self.ownerName = ownerName
        self.createdAt = createdAt
        self.type = type
    }
}