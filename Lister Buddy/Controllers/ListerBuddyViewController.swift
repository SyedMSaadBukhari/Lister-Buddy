//
//  ViewController.swift
//  Lister Buddy
//
//  Created by SyedSaad on 09/05/2022.
//

import UIKit


class ListerBuddyViewController: UITableViewController {

    let defaults = UserDefaults.standard
    var items = [ItemData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem1 = ItemData()
        newItem1.title = "google"
        items.append(newItem1)
        
        let newItem2 = ItemData()
        newItem2.title = "google"
        items.append(newItem2)
        
        let newItem3 = ItemData()
        newItem3.title = "google"
        items.append(newItem3)
        
        
       
        
        if let  item = defaults.array(forKey: "listerBuddyArray") as? [ItemData]{
            
            items = item
        }

    }
//MARK - Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListerBuddyItemCell", for: indexPath)
        
        let anotherItem = items[indexPath.row]
        
        
        cell.textLabel?.text = anotherItem.title
        
        //Ternary operator ... using instead of if else statement
        //value = condition ? valueIfTrue : valueIfFalse
        //anotherItem initially true
    
        cell.accessoryType = anotherItem.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(items[indexPath.row])
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newText = UITextField()
        
        let alert = UIAlertController(title: "Add item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            let   newItem = ItemData()
            newItem.title = newText.text!
            
            self.items.append(newItem)
            
            self.defaults.set(self.items, forKey: "listerBuddyArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newText = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}

