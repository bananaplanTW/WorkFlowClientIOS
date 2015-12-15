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
                print("sendAMessageToTask error")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(TaskActivityDataStore.ACTION_SENT_MESSAGE_TO_TASK, object: nil)
            }
        }
    }
    class func checkInOut (lat: Double?, lng: Double?, address: String?) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.CHECK_IN_OUT, queries: nil)
        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId(),
        ]
        var body: Dictionary = [String: String]()
        if lat != nil && lng != nil {
            body["lat"] = String(lat!)
            body["lng"] = String(lng!)
        }
        if address != nil {
            body["ad"] = address!
        }


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
                print("shiftTask error")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHIFTED_TASK, object: nil)
            }
        }
    }
    class func suspendTask (taskId: String) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.SUSPEND_TASK, queries: nil)
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
                print("suspendTask error")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SUSPENDED_TASK, object: nil)
            }
        }
    }
    class func completeTask (taskId: String) {
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.COMPLETE_TASK, queries: nil)
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
                print("completeTask error")
                print(errors)
                return
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_COMPLETED_TASK, object: nil)
            }
        }
    }
    class func sendAnImageToTask(image: UIImage, imageName: String, taskId: String) {
        let imageData: NSData = UIImageJPEGRepresentation(image, 0.8)!
        let urlString = URLUtils.buildURLString(APIs.BASE_URL, endPoint: APIs.END_POINTS.ADD_IMAGE_TASK_ACTIVITY, queries: nil)
        
        let headers:Dictionary = [
            "x-auth-token": WorkingDataStore.sharedInstance().getAuthToken(),
            "x-user-id": WorkingDataStore.sharedInstance().getUserId(),
            "td": taskId,
            "fn": imageName
        ]

        RestfulUtils.postImage(urlString, headers: headers, imageData: imageData) {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) in
            // should notify system
            if errors != nil {
                print("something wrong")
                print(errors)
                return
            } else {
                print("send image success!")
            }
        }
    }
}