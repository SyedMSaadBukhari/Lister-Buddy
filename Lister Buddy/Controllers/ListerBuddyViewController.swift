//
//  ViewController.swift
//  Lister Buddy
//
//  Created by SyedSaad on 09/05/2022.
//

import UIKit


class ListerBuddyViewController: UITableViewController {

  
    var items = [ItemData]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    
        dataLoader()

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
        
        saveItems()
        
        
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
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newText = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - model Manupulation Methods
    
    func saveItems(){
        
        //encoder
        let encoder = PropertyListEncoder()
          
          do {
              let data = try encoder.encode(items)
              try data.write(to: dataFilePath!)
          }
          catch {
              print("Error -> Item Array  \(error)")
          }
        self.tableView.reloadData()
    }
    
    
    func dataLoader(){
        
        if let data = try?  Data(contentsOf: dataFilePath!){
        //decoder
            let decoder = PropertyListDecoder()
        do {
            items = try decoder.decode([ItemData].self, from: data)
        } catch {
            print("Error decoding,  \(error)")
        }
        }
        
        
        
    }
    
}

