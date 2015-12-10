//
//  Task.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class Task {
    let id:String
    let name: String
    let caseName: String
    
    init (id:String, name: String, caseName: String){
        self.id = id;
        self.name = name;
        self.caseName = caseName;
    }

    class func createTask (attributes: NSDictionary) -> Task {
        return Task(
            id: attributes["_id"] as! String,
            name: attributes["name"] as! String,
            caseName: attributes["caseName"] as! String
        )
    }
}