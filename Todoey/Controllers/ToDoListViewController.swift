//
//  ViewController.swift
//  Todoey
//
//  Created by Unprivileged on 2019-01-29.
//  Copyright © 2019 Unprivileged. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
            print("Did set")
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //MARK -- TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK -- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveChecklist()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK -- Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            print(self.selectedCategory?.name)
            
            self.itemArray.append(newItem)
            
            self.saveChecklist()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item Name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK -- Model Manipulation Methods
    
    func loadItems(request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let requireCategory = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        print(selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [requireCategory, additionalPredicate])
        } else {
            request.predicate = requireCategory
        }
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Unable to fetch data, \(error)")
        }
        tableView.reloadData()
    }
    
    func saveChecklist() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
}


// MARK: Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let filterItemsBasedOnSearch : NSFetchRequest<Item> = Item.fetchRequest()
        let filterPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        filterItemsBasedOnSearch.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(request: filterItemsBasedOnSearch, predicate: filterPredicate)
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
