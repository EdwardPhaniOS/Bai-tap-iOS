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
    var items: [Item] = []
    
    let userDefault = UserDefaults.standard

    //
    //MARK: - View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    func fetchItems() {
        items.removeAll()
        
        let itemsData = userDefault.object(forKey: "arrayItems") as? [Data] ?? []
        
        for itemData in itemsData {
            do {
                let item = try JSONDecoder().decode(Item.self, from: itemData)
                self.items.append(item)
                print(item)
                
            } catch {
                print("Decoding Error: \(error)")
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
        
        //Save on UI
        items.append(item)
        tableView.reloadData()
        
        //Save on User default
        
        var itemsData = userDefault.object(forKey: "arrayItems") as? [Data] ?? []
        
        do {
            let itemData = try JSONEncoder().encode(item)
            itemsData.append(itemData)
            
            userDefault.set(itemsData, forKey: "arrayItems")
        } catch {
            print("Error: \(error)")
        }
        
        
       
    }
    
    func itemEdited(newItem: Item) {
        fetchItems()
    }
}
























//func itemDidAdded() {
//
//        itemKeys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
//
//        if let lastKey = itemKeys.last {
//            if let itemData = userDefault.object(forKey: lastKey) as? Data {
//
//                do {
//                    let item = try JSONDecoder().decode(Item.self, from: itemData)
//                    self.items.append(item)
//
//                } catch {
//                    print("Decoding Error: \(error)")
//                }
//            }
//
//            tableView.reloadData()
//        }
//    }


//func fetchItems() {
//       items.removeAll()
//       itemKeys.removeAll()
//
//       itemKeys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
//
//       for key in itemKeys {
//           if let itemData = userDefault.object(forKey: key) as? Data {
//               do {
//                   let item = try JSONDecoder().decode(Item.self, from: itemData)
//                   self.items.append(item)
//                   print(item)
//
//               } catch {
//                   print("Decoding Error: \(error)")
//               }
//           }
//       }
//
//       tableView.reloadData()
//   }
