//
//  EmployeeScheduledTaskTableViewCell.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class EmployeeScheduledTaskTableViewCell: UITableViewCell {

    var task: Task!

    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
