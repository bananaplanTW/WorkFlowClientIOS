//
//  EmployeeWorkingStatusTableViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeWorkingStatusTableViewController: UITableViewController {

    var employee: Employee?
    var wipTask: Task?
    var scheduletTaskList: Array<Task>!

    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        registerNotificationObservers()
        initData()
        initViews()
    }
    
    func registerNotificationObservers () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEmployeeUpdated", name: WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEmployeeIconUpdated", name: WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE_ICON, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTaskDataUpdated", name: WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE_TASKS, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEndRefreshing", name: WorkingDataStore.ACTION_CANCEL_RELOAD_EMPLOYEE_TASKS, object: nil)
    }
    func initData () {
        employee = WorkingDataStore.sharedInstance().getEmployee()
        
        wipTask = WorkingDataStore.sharedInstance().getWipTask()
        scheduletTaskList = WorkingDataStore.sharedInstance().getScheduledTaskList()
    }
    func initViews () {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "syncTaskData", forControlEvents: UIControlEvents.ValueChanged)

        self.navigationController?.setToolbarHidden(false, animated: false)

        if employee != nil {
            employeeName.text = employee!.name
            employeeIcon.image = employee!.thumb
        }
    }
    


    func onEmployeeUpdated () {
        if let _employee = WorkingDataStore.sharedInstance().getEmployee() {
            employee = _employee
            employeeName.text = _employee.name
            syncTaskData()
        }
    }
    func onEmployeeIconUpdated () {
        employeeIcon.image = employee!.thumb
    }


    func syncTaskData () {
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
                cell.task = _wipTask
                cell.taskName.text = _wipTask.name
                cell.caseName.text = _wipTask.caseName
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("EmployeePendingTableViewCell", forIndexPath: indexPath) as! EmployeePendingTableViewCell
                return cell
            }

            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EmployeeScheduledTaskTableViewCell", forIndexPath: indexPath) as! EmployeeScheduledTaskTableViewCell
            let task = scheduletTaskList[indexPath.row]

            cell.task = task
            cell.taskName.text = task.name
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

    @IBAction func onCheckingIn(sender: UIBarButtonItem) {

        if employee != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let employeeCheckInOutPromptViewController = storyboard.instantiateViewControllerWithIdentifier("EmployeeCheckInOutPromptViewController") as! EmployeeCheckInOutPromptViewController
            employeeCheckInOutPromptViewController.employee = employee!

            self.presentViewController(employeeCheckInOutPromptViewController, animated: true, completion: nil)
        }
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
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath)
////        if indexPath.section == 1 {
////            let storyboard = UIStoryboard(name: "Main", bundle: nil)
////            let scheduledTaskActionsPromptViewController = storyboard.instantiateViewControllerWithIdentifier("ScheduledTaskActionsPromptViewController") as! ScheduledTaskActionsPromptViewController
////
////            scheduledTaskActionsPromptViewController.task = scheduletTaskList[indexPath.row]
////            self.presentViewController(scheduledTaskActionsPromptViewController, animated: true, completion: nil)
////        }
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segueTaskDetails" {
            let destinationViewController: TaskDetailsViewController = segue.destinationViewController as! TaskDetailsViewController

            switch sender {
            case is EmployeeCurrentTaskTableViewCell:
                destinationViewController.task = (sender as! EmployeeCurrentTaskTableViewCell).task
                break
            case is EmployeeScheduledTaskTableViewCell:
                destinationViewController.task = (sender as! EmployeeScheduledTaskTableViewCell).task
                break
            default:
                break
            }

        }
    }

}
