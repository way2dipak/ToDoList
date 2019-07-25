//
//  ToDoListViewController.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

enum CellAction {
    case add
    case update
}

class ToDoListViewController: UIViewController {
    
    static let identifier = "ToDoListViewController"
    
    @IBOutlet weak var listTableView: UITableView!
    
    var dataSource: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    var navTitle = ""
    var cId = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navTitle
       
        listTableView.tableFooterView = UIView()
        dataSource.removeAll()
        let details = DBManager.shared.fetchDetailsFromProductTable()
        dataSource = details.filter{$0.cId == self.cId}
        
        
    }
    
    
    
    
    @IBAction func onTappedAddButton(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddToDoViewController.identifier) as! AddToDoViewController
        vc.dbDelegate = self
        vc.cellAction = .add
        vc.vcType = .product
        vc.cId = cId
        self.present(vc, animated: true, completion: nil)
    }


}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier) as! ToDoListTableViewCell
        let details = dataSource[indexPath.row]
        cell.itemNameLabel.text = details.itemName
        if details.isPending {
            cell.pendingStatusButton.setTitle("Done", for: .normal)
            cell.pendingStatusButton.setTitleColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), for: .normal)
        }
        else {
            cell.pendingStatusButton.setTitle("Pending", for: .normal)
            cell.pendingStatusButton.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let status = UITableViewRowAction(style: .normal, title: "Done") { action, index in
            let check = DBManager.shared.updatePendingStatusInProductTable(pId: self.dataSource[index.row].id, isPending: true)
            if check {
                self.dataSource.removeAll()
                let details = DBManager.shared.fetchDetailsFromProductTable()
                self.dataSource = details.filter{$0.cId == self.cId}
            }
        }
        status.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        let update = UITableViewRowAction(style: .normal, title: "Update") { action, index in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: AddToDoViewController.identifier) as! AddToDoViewController
            vc.dbDelegate = self
            vc.vcType = .product
            vc.cellAction = .update
            vc.pId = self.dataSource[index.row].id
            vc.todoString = self.dataSource[index.row].itemName
            self.present(vc, animated: true, completion: nil)
        }
        update.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let check = DBManager.shared.DeleteRecordsFromProductTable(pId: self.dataSource[index.row].id)
            if check {
                self.dataSource.removeAll()
                let details = DBManager.shared.fetchDetailsFromProductTable()
                self.dataSource = details.filter{$0.cId == self.cId}
                
            }
            else {
                print("Failed to Delete")
            }
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [status, delete, update]
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ToDoListViewController: DBDelegate {
    func checkStatus(success: Bool) {
        if success {
            dataSource.removeAll()
            let details = DBManager.shared.fetchDetailsFromProductTable()
            dataSource = details.filter{$0.cId == self.cId}
        }
    }
}
