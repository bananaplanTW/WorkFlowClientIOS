//
//  PostAPI.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/13/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation

class PostAPI {
    class func sendAMessageToTask (message: String, taskId: String) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.ADD_TEXT_TASK_ACTIVITY, queries: nil)
        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId(),
        ]
        let body: Dictionary = [
            "td": taskId,
            "msg": message,
        ]
        
        
        RestfulUtils.post(urlString, headers: headers, body: body) {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) in
            // should notify system
            if errors != nil {
                print("something wrong")
                print(errors)
                return
            } else {
                print("send message success!")
            }
        }
    }
    class func checkInOut () {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.CHECK_IN_OUT, queries: nil)
        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId(),
        ]
        let body: Dictionary = [String: String]()


        RestfulUtils.post(urlString, headers: headers, body: body) {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) in
            // should notify system
            if errors != nil {
                print("something wrong")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_EMPLOYEE_CHECK_IN_OUT, object: nil)
            }
        }
    }


    class func shiftTask (taskId: String) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.SHIFT_TASK, queries: nil)
        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId(),
        ]
        let body: Dictionary = [
            "td": taskId
        ]

        RestfulUtils.post(urlString, headers: headers, body: body) {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) in
            // should notify system
            if errors != nil {
                print("something wrong")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHIFTED_TASK, object: nil)
            }
        }
    }
}