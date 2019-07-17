//
//  ListViewController.swift
//  MasterList
//
//  Created by Zakeel Muhammad on 7/16/19.
//  Copyright © 2019 Zakeel Muhammad. All rights reserved.
//

import UIKit
import AppCenterAuth

class ListViewController: UITableViewController {

    private var todoItems = [ToDoItem]()
    private var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Master List"
        signIn()

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ListViewController.didTapAddItemButton(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(ListViewController.signOut))
        
      
    }
    
    func signIn() {
        
        MSAuth.signIn { userInformation, error in
            
            if error == nil {
                // Sign-in succeeded.
                //var accountId = userInformation!.accountId;
               // var idToken = userInformation.
                let idToken = userInformation?.idToken
                let tokenSplit = idToken?.components(separatedBy: ".")
                if tokenSplit != nil && tokenSplit!.count > 1 {
                    var rawClaims = tokenSplit![1]
                    let paddedLength = rawClaims.count + (4 - rawClaims.count % 4) % 4
                    rawClaims = rawClaims.padding(toLength: paddedLength, withPad: "=", startingAt: 0)
                    let claimsData = Data(base64Encoded: rawClaims, options: .ignoreUnknownCharacters)
                    do {
                        if claimsData != nil {
                            let claims = try JSONSerialization.jsonObject(with: claimsData!, options: []) as? [AnyHashable: Any]
                            if claims != nil {
                                
                                    // Get display name.
                                    let displayName = claims!["given_name"] as! String
                                    // Do something with display name.
                                    self.userName = displayName as! String
                                    self.title = "\(self.userName)'s Master List"
                                
                               
                            }
                        }
                    } catch {
                        
                        // Handle error.
                    }
                }
                
                
            } else {
                // Do something with sign failure.
            }
            
        }
        
    }
    
    @objc func signOut() {
        MSAuth.signOut()
        empty()
        signIn()
    }
    
    func empty() {
        self.todoItems = []
        self.userName = String()
        self.title = "Master List"
        tableView.reloadData()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath)
        
        if indexPath.row < todoItems.count {
            let item = todoItems[indexPath.row]
            cell.textLabel?.text = item.title
            
            let accessory: UITableViewCell.AccessoryType = item.isDone ? .checkmark : .none
            cell.accessoryType = accessory
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < todoItems.count {
            let item = todoItems[indexPath.row]
            item.isDone = !item.isDone
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem) {
        
        // Create an alert
        let alert = UIAlertController(
            title: "New to-do item",
            message: "Insert the title of the new to-do item:",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField(configurationHandler: nil)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.addNewToDoItem(title: title)
            }
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func addNewToDoItem(title: String)
    {
        // The index of the new item will be the current item count
        let newIndex = todoItems.count
        
        // Create new item and add it to the todo items list
        todoItems.append(ToDoItem(title: title))
        
        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < todoItems.count {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    


}

