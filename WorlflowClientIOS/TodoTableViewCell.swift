//
//  TodoTableViewCell.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/11/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxContainer: UIView!
    @IBOutlet weak var todoName: UILabel!
    
    var checkbox: BEMCheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initCheckbox()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCheckbox () {
        checkbox = BEMCheckBox(frame: CGRectMake(0, 0, 30, 30))
        checkbox.boxType = BEMBoxType.Square
        checkboxContainer.addSubview(checkbox)
    }

}
