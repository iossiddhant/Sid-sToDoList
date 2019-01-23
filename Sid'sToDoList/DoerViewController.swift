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
    override func viewDidLoad() {
        super.viewDidLoad()
       
  
    }
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


}

