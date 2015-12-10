//
//  URLUtils.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class URLUtils {
    class func buildURLString (baseURL: String, endPoint: String, queries: Dictionary<String, String>?) -> String {
        let queryString:String = URLUtils.buildQueryString(queries)
        if queryString.characters.count > 0 {
            return baseURL + endPoint + "?" + queryString
        } else {
            return baseURL + endPoint
        }
    }
    
    
    class func buildQueryString (queries: Dictionary<String, String>?) -> String {
        var queryString:String = ""
        if let _queries = queries {
            for (key, value) in _queries {
                queryString += "\(key)=\(value)&"
            }
        }
        if queryString.characters.count > 0 {
            queryString.removeAtIndex(queryString.endIndex.predecessor())
        }
        return queryString
    }
}