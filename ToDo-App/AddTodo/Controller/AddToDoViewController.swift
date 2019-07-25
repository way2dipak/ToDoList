//
//  AddToDoViewController.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

protocol DBDelegate {
    func checkStatus(success: Bool)
}

class AddToDoViewController: UIViewController {
    
    static let identifier = "AddToDoViewController"
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    

    var dbDelegate: DBDelegate?
    var todoString = ""
    var pId = 0
    var cellAction: CellAction = .add
    var vcType: VCType = .none
    var cId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if todoString != "" {
            itemNameTextField.text = todoString
            addButton.setTitle("Update", for: .normal)
        }
        else {
            addButton.setTitle("Add", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dbDelegate?.checkStatus(success: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedAddButton(_ sender: UIButton) {
        if itemNameTextField.text! == "" {
            print("Insert ToDo")
        }
        else {
            if vcType == .category {
                
                    let check = DBManager.shared.saveToCategoryTable(categoryName: itemNameTextField.text!)
                    if check {
                        dbDelegate?.checkStatus(success: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        print("Failed To Add")
                    }
            }
            else if vcType == .product {
                if cellAction == .add {
                    let check = DBManager.shared.saveToProductTable(productName: itemNameTextField.text!, cid: cId, isPending: false)
                    if check {
                        dbDelegate?.checkStatus(success: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        print("Failed To Add")
                        
                    }
                }
                else {
                    let check = DBManager.shared.updateProductTable(pId: pId, productName: itemNameTextField.text!)
                    if check {
                        dbDelegate?.checkStatus(success: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        print("Failed To Update")
                        
                    }
                }
            }
            
        }
        
    }
    @IBAction func onTappedCancelButton(_ sender: UIButton) {
        dbDelegate?.checkStatus(success: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
