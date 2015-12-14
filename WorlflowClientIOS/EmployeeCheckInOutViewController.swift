//
//  EmployeeCheckInOutViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/14/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeCheckInOutPromptViewController: UIViewController {

    var employee: Employee!

    @IBOutlet var background: UIView!
    @IBOutlet weak var promptContainer: UIView!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var checkOutTime: UILabel!
    @IBOutlet weak var checkInOutButton: UIButton!
    @IBOutlet weak var location: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        initGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initViews () {
        promptContainer.layer.borderWidth = 1
        promptContainer.layer.borderColor = UIColor.grayColor().CGColor
        promptContainer.layer.cornerRadius = 10


        switch employee.status {
        case .STOP, .OFF:
            checkInTime.text = "尚未上班"
            checkOutTime.text = "尚未上班"
            checkInOutButton.setTitle("打卡上班", forState: UIControlState.Normal)
            break
        case .WIP, .PENDING, .PAUSE:
            if let timecard = employee.timecard {
                checkInTime.text = NSDateFormatter.localizedStringFromDate(timecard.startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                checkOutTime.text = "尚未下班"
                checkInOutButton.setTitle("打卡下班", forState: UIControlState.Normal)
            } else {
                // 打卡錯誤
            }
            break;
        }
    }
    func initGestures () {
        let promptContainerGesture = UITapGestureRecognizer(target: self, action: "onTapPromptContainer:")
        promptContainer.addGestureRecognizer(promptContainerGesture)

        let backgroundGesture = UITapGestureRecognizer(target: self, action: "onTapBackground:")
        background.addGestureRecognizer(backgroundGesture)
    }
    
    
    func onTapPromptContainer (sender: UITapGestureRecognizer) {
        // no ops
    }
    func onTapBackground (sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
