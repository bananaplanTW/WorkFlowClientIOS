//
//  User.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/14/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class User {
    let id: String!
    let name: String!
    let iconPath: String?

    init (id: String, name: String, iconPath: String?) {
        self.id = id
        self.name = name
        self.iconPath = iconPath
    }
}