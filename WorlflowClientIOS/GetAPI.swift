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
}