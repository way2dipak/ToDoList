//
//  ToDoListTableViewCell.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListTableViewCell"
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var pendingStatusButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
