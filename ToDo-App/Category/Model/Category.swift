//
//  Category.swift
//  ToDo-App
//
//  Created by admin on 25/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation


struct Category {
    
    var id: Int
    var itemName: String
    
    
    init(id: Int, itemName: String) {
        self.id = id
        self.itemName = itemName
    }
    
}
