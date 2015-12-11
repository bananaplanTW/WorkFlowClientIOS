//
//  TaskDetailsViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var taskActivityDataStoreInstance: TaskActivityDataStore!
    // will be set by parent view controller
    var task: Task!

    var taskId: String!
    var taskActivities: Array<Activity>!
    var activityType: ActivityType!
    var isShowingTodo: Bool!

    @IBOutlet weak var taskDetailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotificationObservers()
        initData()
    }

    func registerNotificationObservers () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTaskActivityDataUpdated", name: TaskActivityDataStore.ACTION_UPDATE_TASK_ACTIVITIES, object: nil)
    }
    
    func initData () {
        taskActivityDataStoreInstance = TaskActivityDataStore.sharedInstance()
        taskId = task.id
        
        isShowingTodo = true
        activityType = .TASK_COMMENT
        taskActivities = taskActivityDataStoreInstance.getTaskActivitiesByTaskId(taskId)
        
        taskActivityDataStoreInstance.syncTaskActivities(taskId)
    }

    func onTaskActivityDataUpdated () {
        taskActivities = taskActivityDataStoreInstance.getTaskActivitiesByTaskId(taskId)
        taskDetailsTableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingTodo == true {
            return task.todos.count
        }
        
        let count: Int = taskActivities.reduce(0, combine: {$0 + ($1.type == activityType ? 1 : 0)})
        return count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isShowingTodo == true {
            return 50
        }
        
        switch activityType! {
        case .TASK_COMMENT, .TASK_FILE:
            return 85
        case .TASK_PHOTO:
            return 240
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // for render todo table view cell
        if isShowingTodo == true {
            let todo = task.todos[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("TodoTableViewCell", forIndexPath: indexPath) as! TodoTableViewCell
            cell.todoName.text = todo.name
            cell.checkbox.on = todo.checked
            return cell
        }


        let activity = taskActivities.filter({$0.type == activityType})[indexPath.row]
        switch activityType! {
        case .TASK_COMMENT:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCommentTableViewCell", forIndexPath: indexPath) as! ActivityCommentTableViewCell
            cell.employeeName.text = activity.ownerName
            cell.time.text = NSDateFormatter.localizedStringFromDate(activity.createdAt, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            cell.comment.text = (activity as! TaskCommentActivity).comment
            return cell

        case .TASK_PHOTO:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityPhotoTableViewCell", forIndexPath: indexPath) as! ActivityPhotoTableViewCell
            cell.time.text = NSDateFormatter.localizedStringFromDate(activity.createdAt, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            cell.employeeName.text = activity.ownerName
            return cell

        case .TASK_FILE:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityFileTableViewCell", forIndexPath: indexPath) as! ActivityFileTableViewCell
            cell.employeeName.text = activity.ownerName
            cell.time.text = NSDateFormatter.localizedStringFromDate(activity.createdAt, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            cell.fileName.text = (activity as! TaskFileActivity).fileName
            return cell
        }
    }
    
    @IBAction func activityTypeIndexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isShowingTodo = true
            break
        case 1:
            activityType = .TASK_COMMENT
            isShowingTodo = false
            break
        case 2:
            activityType = .TASK_PHOTO
            isShowingTodo = false
            break
        case 3:
            activityType = .TASK_FILE
            isShowingTodo = false
            break;
        default:
            break
        }
        
        taskDetailsTableView.reloadData()
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
