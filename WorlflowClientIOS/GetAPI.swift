//
//  GetAPI.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/13/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class GetAPI {
    class func getImage (imagePath: String, backward: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        let imageUrl:String = URLUtils.buildURLString(APIs.BASE_URL, endPoint: imagePath, queries: nil)
        RestfulUtils.getDataFromUrl(imageUrl, backward: backward)
    }
    class func checkLogin(backward: (NSURLResponse!, NSData?, NSError!) -> Void) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.CHECK_LOGIN, queries: nil)

        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId()
        ]
        RestfulUtils.get(urlString, headers: headers, backward: backward)
    }
}