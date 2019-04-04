
//
//  CategoryVC.swift
//  inote
//
//  Created by ahmed abokhalil on 7/28/1440 AH.
//  Copyright © 1440 AH ahmed abokhalil. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryVC: UITableViewController {
    
    let realm = try! Realm() // inialize new access to realm
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    // called whenever we call reloadData()
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // nil Coalescing Operator , return number of Categories as the numberOfRows
        return categories?.count ?? 1  // if categories is nil , return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Addes Yet"
        
        return cell
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    // trigered before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! InoteListVC
        // grab category corresponds to selected cell
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods.
    
    func save(Category : Category) {
        do {
            try realm.write {
                realm.add(Category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    // fetch all objects belong to Category
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()

    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //self.categories.append(newCategory) // since result updated auto
            
            self.save(Category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}

