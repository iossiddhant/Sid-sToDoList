//
//  ViewController.swift
//  Sid'sToDoList
//
//  Created by Siddhant Mahapatra on 1/23/19.
//  Copyright © 2019 Siddhant Mahapatra. All rights reserved.
//

import UIKit
import CoreData

class DoerViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var arrDoer =  [DoerItem]()
    var filteredArr = [DoerItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
   // let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Doer.plist")
    // Here all my initialization code will be kept.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchItems()
        searchBar.delegate = self
    }
    
    func deleteItem(at index: Int)  {
        context.delete(filteredArr[index])
        filteredArr.remove(at: index)
    }
    
    func fetchItems()  {
        var request:NSFetchRequest<DoerItem> = DoerItem.fetchRequest()
        do {
      arrDoer =   try context.fetch(request)
    filteredArr = arrDoer
            
        }catch{
            print("Error while Fetching..")
            return
        }
        
        self.tableView.reloadData()
    }
    
    
    func saveItems(title:String, isDone:Bool)  {
        
        var item = DoerItem(context: self.context)
        item.title = title
        item.done = isDone
       self.saveContext()
      

    }
    func saveContext()  {
        do {
            try self.context.save()
        }catch
        {
            print("Error in Savin Data")
        }
         self.fetchItems()
    }
    //MARK: Here goes the tableview delegates which comes packed with uitableviewcontroller
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoerCell", for: indexPath)
        cell.textLabel?.text = filteredArr[indexPath.row].title
        cell.accessoryType = filteredArr[indexPath.row].done ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // arrDoer[indexPath.row].done = !arrDoer[indexPath.row].done
    self.deleteItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveContext()
        
       
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
       var textField = UITextField()
        var alert = UIAlertController(title: "Doer", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Doer", style: .default) { (action) in
        //  var path  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
           // print(path[0])
            print("Succeed.")
          
          self.saveItems(title: textField.text!, isDone: false)
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


extension DoerViewController: UISearchBarDelegate
{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0
        {
            filteredArr = arrDoer
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
           
        }else
        {
            filteredArr.removeAll(keepingCapacity: false)
            filteredArr = arrDoer.filter{ ($0.title?.localizedCaseInsensitiveContains(searchText))!}
        }
        self.tableView.reloadData()
            
            //arrDoer.filter { $0.title?.localizedCaseInsensitiveContains(searchBar.text)  }
    }
    
}
