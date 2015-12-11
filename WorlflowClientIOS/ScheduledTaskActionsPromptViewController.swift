//
//  ScheduledTaskActionsPromptViewController.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class ScheduledTaskActionsPromptViewController: UIViewController {

    var task: Task!
    
    @IBOutlet weak var promptIcon: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func initViews () {
        taskName.text = task.name
    }


    @IBAction func onShowingTaskDetails(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onStartingTask(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
