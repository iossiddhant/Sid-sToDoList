//
//  ViewController.swift
//  Sid'sToDoList
//
//  Created by Siddhant Mahapatra on 1/23/19.
//  Copyright © 2019 Siddhant Mahapatra. All rights reserved.
//

import UIKit

class DoerViewController: UITableViewController {

    var arrDoer = ["murli reading", "prepare food", "finish swift 4.2", "finish kotlin"]
   
    // Here all my initialization code will be kept.
    override func viewDidLoad() {
        super.viewDidLoad()
       
  
    }
    //MARK: Here goes the tableview delegates which comes packed with uitableviewcontroller
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoerCell", for: indexPath)
        cell.textLabel?.text = arrDoer[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDoer.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
       {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else
       {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
       var textField = UITextField()
        var alert = UIAlertController(title: "Doer", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Doer", style: .default) { (action) in
            print("Succeed.")
            self.arrDoer.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Enter a doer."
            textField = alerttextField
        }
        
        self.present(alert, animated: true) {
            print("Just completed presenting the alert.")
        }
        
    }
    
}

