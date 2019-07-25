//
//  ViewController.swift
//  ToDo-App
//
//  Created by admin on 24/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

enum VCType {
    case category
    case product
    case none
}


class CategoryViewController: UIViewController {
    
    static let identifier = "CategoryViewController"

    
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    var dataSource: [Category] = [] {
        didSet {
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.tableFooterView = UIView()
        dataSource.removeAll()
        dataSource = DBManager.shared.fetchDetailsFromCategory()
    }
    
    @IBAction func onTappedAddButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddToDoViewController.identifier) as! AddToDoViewController
        vc.dbDelegate = self
        vc.vcType = .category
        self.present(vc, animated: true, completion: nil)
    }
    


}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        let details = dataSource[indexPath.row]
        cell.categoryLabel.text = details.itemName.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ToDoListViewController.identifier) as! ToDoListViewController
       vc.navTitle = dataSource[indexPath.row].itemName.capitalized
        vc.cId = dataSource[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let check = DBManager.shared.DeleteRecordsFromCategoryTable(cId: self.dataSource[index.row].id)
            if check {
                let check = DBManager.shared.DeleteRecordsFromProductTableFrom(cId: self.dataSource[index.row].id)
                if check {
                    self.dataSource.removeAll()
                    self.dataSource = DBManager.shared.fetchDetailsFromCategory()
                }
                else {
                    print("FailedToDelete")
                }
            }
            else {
                print("FailedToDelete")
            }
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CategoryViewController: DBDelegate {
    func checkStatus(success: Bool) {
        if success {
            dataSource.removeAll()
            dataSource = DBManager.shared.fetchDetailsFromCategory()
        }
    }
}
