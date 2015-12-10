//
//  RestfulUtils.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class RestfulUtils {
    class func get (urlString: String, headers: Dictionary<String, String>, backward: (NSURLResponse!, NSData?, NSError!) -> Void) {

        let urlRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) -> Void in
                backward(response, data, errors)
        }
    }
}