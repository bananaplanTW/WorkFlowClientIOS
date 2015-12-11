//
//  EmployeeWorkingStatusTableViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeWorkingStatusTableViewController: UITableViewController {

    var wipTask: Task? = WorkingDataStore.sharedInstance().getWipTask()
    var scheduletTaskList: Array<Task> = WorkingDataStore.sharedInstance().getScheduledTaskList()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        registerNotificationObservers()
        initViews()
    }
    
    func registerNotificationObservers () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTaskDataUpdated", name: WorkingDataStore.ACTION_UPDATE_EMPLOYEE_TASKS, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEndRefreshing", name: WorkingDataStore.ACTION_CANCEL_UPDATE_EMPLOYEE_TASKS, object: nil)
    }

    func initViews () {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "onRefreshingTaskData", forControlEvents: UIControlEvents.ValueChanged)
    }

    func onRefreshingTaskData () {
        WorkingDataStore.sharedInstance().syncTasks()
    }

    func onTaskDataUpdated () {
        wipTask = WorkingDataStore.sharedInstance().getWipTask()
        scheduletTaskList = WorkingDataStore.sharedInstance().getScheduledTaskList()
        
        tableView.reloadData()
        
        onEndRefreshing()
    }
    func onEndRefreshing () {
        if refreshControl != nil {
            refreshControl?.endRefreshing()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return scheduletTaskList.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {

            if let _wipTask = wipTask {
                let cell = tableView.dequeueReusableCellWithIdentifier("EmployeeCurrentTaskTableViewCell", forIndexPath: indexPath) as! EmployeeCurrentTaskTableViewCell
                cell.taskName.text = _wipTask.name
                cell.caseName.text = _wipTask.caseName
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("EmployeePendingTableViewCell", forIndexPath: indexPath) as! EmployeePendingTableViewCell
                return cell
            }

            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EmployeeScheduledTaskTableViewCell", forIndexPath: indexPath) as! EmployeeScheduledTaskTableViewCell
            
            cell.taskName.text = scheduletTaskList[indexPath.row].name
            cell.index.text = String(indexPath.row + 1)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else {
            return 60
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 40))
        let titleLabel = UILabel(frame: CGRectMake(10, 0, UIScreen.mainScreen().bounds.size.width, 40))
        titleLabel.font = UIFont(name: "Avenir-Regular", size: 10.0)
        
        if section == 0 {
            titleLabel.text = "目前工作"
        } else {
            titleLabel.text = "下個工作"
        }
        
        sectionView.addSubview(titleLabel)
        
        return sectionView
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
