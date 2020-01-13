//
//  ListToDoVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

class ListToDoVC: UITableViewController {
        
    //
    //MARK: - Variable
    //
    var itemKeys: [String] = []
    var items: [Item] = []

    //
    //MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems()
    }
    
    func fetchItems() {
        itemKeys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
        
        for key in itemKeys {
            if let itemData = userDefault.object(forKey: key) as? Data {
                do {
                    let item = try JSONDecoder().decode(Item.self, from: itemData)
                    self.items.append(item)
                    
                } catch {
                    print("Decoding Error: \(error)")
                }
            }
        }
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
        
        cell.setUpUI(title: item.title, description: item.description, dateCreated: dateString)
        
        return cell
    }

    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "gotoCreateItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoCreateItem" {
            let createToDoVC = segue.destination as! CreateItemVC
            createToDoVC.createItemDelegate = self
        }
    }
}

//
//MARK: - CreateItemVCDelegate
//
extension ListToDoVC: CreateItemVCDelegate {
    
    func itemDidAdded() {

        itemKeys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
        
        if let lastKey = itemKeys.last {
            if let itemData = userDefault.object(forKey: lastKey) as? Data {
                
                do {
                    let item = try JSONDecoder().decode(Item.self, from: itemData)
                    self.items.append(item)
                    
                } catch {
                    print("Decoding Error: \(error)")
                }
            }
            
            tableView.reloadData()
        }
    }
}
