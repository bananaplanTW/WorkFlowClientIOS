//
//  Todo.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class Todo {
    let name: String!
    let checked: Bool!
    
    init (name: String, checked: Bool) {
        self.name = name
        self.checked = checked
    }
    
    class func createTodo (todoAttributes: NSDictionary) -> Todo {
        return Todo(
            name:    todoAttributes["name"] as! String,
            checked: todoAttributes["checked"] as! Bool
        )
    }
}