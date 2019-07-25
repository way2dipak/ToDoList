//
//  CategoryTableViewCell.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//


import UIKit


class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
