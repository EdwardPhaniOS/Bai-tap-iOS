//
//  ListToDoVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

class ListToDoVC: UITableViewController {

    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell {
            
            let item = items[indexPath.row]
            cell.cellTitle.text = item.title
            cell.cellDescription.text = item.description
            
        }
        
    }
    

    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "gotoCreateItem", sender: nil)
        
    }
}
