//
//  ActivityCommentTableViewCell.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/10/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class ActivityCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
