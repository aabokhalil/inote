
//
//  ViewController.swift
//  inote
//
//  Created by ahmed abokhalil on 7/27/1440 AH.
//  Copyright © 1440 AH ahmed abokhalil. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import SwipeCellKit

class InoteListVC: SwipeTableVC {
    
    var inoteItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet { // call loaditems where we're certain we've already got data for selectCa
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
     //   loadItems()
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inoteItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = inoteItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
       
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    // update , delete
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        
        self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        }
        

    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Inote Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Data()
                    currentCategory.items.append(newItem)
                    }
                
                } catch {
                    print("Error saving new items \(error)")
                }

            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manupulation Methods
    
    func loadItems() {
        
        inoteItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

    }
    
    
    // delete 
    override func updateModel(at indexPath: IndexPath) {
        
        if let item = inoteItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                    //item.done = !item.done
                }
                
            } catch {
                print("Error from table delegate in inotevc \(error)")
            }
            
        }
    }
    
}


//MARK - Search bar Methods

extension InoteListVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        inoteItems = inoteItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

