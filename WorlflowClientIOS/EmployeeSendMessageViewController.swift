//
//  EmployeeSendMessageViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeSendMessageViewController: UIViewController {
    
    var taskId: String!
    
    @IBOutlet weak var messageBox: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotificationObservers()
        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerNotificationObservers () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func initViews () {
        initMessageBox()
    }

    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSendingMessage(sender: UIButton) {
        PostAPI.sendAMessageToTask(messageBox.text, taskId: taskId)

        messageBox.resignFirstResponder()
        self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        initMessageBox()
    }
    
    
    func keyboardWillBeShown (notification : NSNotification) {
        let info = notification.userInfo
        let endSize = (info![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let viewHeight = UIScreen.mainScreen().bounds.height - endSize.height

        self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, viewHeight)
        
        typingMessageBox()
    }

    
    func initMessageBox () {
        messageBox.text = "Leave Messages"
        messageBox.textColor = UIColor.grayColor()
    }
    func typingMessageBox () {
        messageBox.text = ""
        messageBox.textColor = UIColor.blackColor()
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
