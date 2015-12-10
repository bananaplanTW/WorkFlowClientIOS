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
}