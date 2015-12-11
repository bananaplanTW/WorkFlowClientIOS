//
//  TaskDetailsViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 85
        } else if indexPath.row == 1 {
            return 240
        } else {
            return 85
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCommentTableViewCell", forIndexPath: indexPath) as! ActivityCommentTableViewCell
            cell.employeeName.text = "DANNY"
            cell.comment.text = "this is generated from TaskDetailsViewController, today is a really good day to go outside!"
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityPhotoTableViewCell", forIndexPath: indexPath) as! ActivityPhotoTableViewCell
            cell.employeeName.text = "DANNY"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityFileTableViewCell", forIndexPath: indexPath) as! ActivityFileTableViewCell
            cell.employeeName.text = "DANNY"
            return cell
        }
        
    }
    
    @IBAction func activityTypeIndexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("todos")
        case 1:
            print("comments")
        case 2:
            print("photos")
        case 3:
            print("files")
        default:
            break;
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
