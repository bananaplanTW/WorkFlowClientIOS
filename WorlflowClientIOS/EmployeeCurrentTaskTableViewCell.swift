//
//  EmployeeCurrentTaskTableViewCell.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeCurrentTaskTableViewCell: UITableViewCell {

    var task: Task!

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var caseName: UILabel!
    @IBOutlet weak var suspendButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initViews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func initViews () {
        suspendButton.layer.borderWidth = 1
        suspendButton.layer.borderColor = UIColor.grayColor().CGColor

        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.grayColor().CGColor
    }


    @IBAction func handleSuspendTask(sender: UIButton) {
        PostAPI.suspendTask(task.id)
    }
    @IBAction func handleCompleteTask(sender: UIButton) {
        PostAPI.completeTask(task.id)
    }
}
