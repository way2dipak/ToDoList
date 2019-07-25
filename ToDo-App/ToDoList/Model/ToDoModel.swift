//
//  ToDoModel.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation


struct Product {
    
    var id: Int
    var cId: Int
    var itemName: String
    var isPending: Bool
    

    init(id: Int, cId: Int, itemName: String, isPending: Bool) {
        self.id = id
        self.cId = cId
        self.itemName = itemName
        self.isPending = isPending
    }
    
}
