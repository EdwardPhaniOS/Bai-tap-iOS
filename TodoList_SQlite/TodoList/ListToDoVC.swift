//
//  ListToDoVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

//let uuid: String
//var title: String
//var description: String
//var date: Date
//var location: Location?

import UIKit
import SQLite3

class ListToDoVC: UITableViewController {
        
    //
    //MARK: - Variable
    //
    var items: [Item] = []
    
    var db: OpaquePointer?
    
    //
    //MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("myDataBase.db") else {
            return
        }
        
        print(fileURL)
        
        //open db
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        //create table
        
        let createStatement = "CREATE TABLE IF NOT EXISTS ITEMS (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT, location TEXT)"
        
        if sqlite3_exec(db, createStatement, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
            return
        }
        
        //fetch value
        fetchItems()
    }
    
    func fetchItems() {
        var stmt: OpaquePointer?
        
        
        if sqlite3_prepare(db, "SELECT id, title, description, date, location from ITEMS", -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db!))
            print("failure preparing select: \(errmsg)")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            
            if let cStringName = sqlite3_column_text(stmt, 1) {
                let title = String(cString: cStringName)
                 print("title = \(title);", terminator: " ")
                
            } else {
                print("name not found")
            }
        }
        
        
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = items[indexPath.row]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormater.string(from: item.date)
        
        cell.setUpUI(title: item.title, description: item.description, dateCreated: dateString, location: item.location)
        
        return cell
    }

    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "gotoCreateItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createToDoVC = segue.destination as? CreateItemVC {
            createToDoVC.createItemDelegate = self
            createToDoVC.currentItem = sender as? Item
        }
    }
    
    //
    //MARK: - Table View Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        self.performSegue(withIdentifier: "gotoCreateItem", sender: item)
    }
}

//
//MARK: - CreateItemVCDelegate
//
extension ListToDoVC: CreateItemVCDelegate {
    
    func itemDidAdded(item: Item) {
        var stmt: OpaquePointer?
        
        //query
        let queryString = "INSERT INTO ITEMS (title, description, date, location) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
            return
        }
        
        let title = item.title as NSString
        let description = item.description as NSString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let date: NSString = dateFormatter.string(from: item.date) as NSString
        let location = "\(item.location?.latitude ?? 0), \(item.location?.longtitude ?? 0)" as NSString
        
        if sqlite3_bind_text(stmt, 1, title.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding age: \(errmsg)")
        }

        if sqlite3_bind_text(stmt, 2, description.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding age: \(errmsg)")
        }
        
        if sqlite3_bind_text(stmt, 3, date.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding age: \(errmsg)")
        }
        
        if sqlite3_bind_text(stmt, 4, location.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding age: \(errmsg)")
        }

        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Failure insert: \(errmsg)")
        }
    }
    
    func itemEdited(newItem: Item) {
        fetchItems()
    }
}


















