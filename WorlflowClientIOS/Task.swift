//
//  Task.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

enum TaskStatusType: String {
    case UNCLAIMED = "unclaimed"
    case PENDING = "pending"
    case WIP = "wip"
    case EXCEPTION = "exception"
    case PAUSE = "pause"
    case STOP = "stop"
    case DONE = "done"
    case CANCEL = "cancel"
    case INREVIEW = "inreview"
}

class Task {
    let id:String
    let name: String
    let caseName: String
    var status: TaskStatusType
    var todos: Array<Todo> = []
    
    init (id:String, name: String, caseName: String, status: TaskStatusType){
        self.id = id
        self.name = name
        self.caseName = caseName
        self.status = status
    }

    class func createTask (attributes: NSDictionary) -> Task {
        let task = Task(
            id: attributes["_id"] as! String,
            name: attributes["name"] as! String,
            caseName: attributes["caseName"] as! String,
            status: TaskStatusType(rawValue: attributes["status"] as! String)!
        )

        var todos: Array<Todo> = []
        for todoAttributes in attributes["todos"] as! NSArray {
            todos.append(Todo.createTodo(todoAttributes as! NSDictionary))
        }
        task.todos = todos
        return task
    }
}