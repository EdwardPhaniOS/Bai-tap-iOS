//
//  ListCardController.swift
//  GameBaiCao
//
//  Created by iMac_VTCA on 11/4/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ListCardController: UITableViewController {
    
    let cardBrain = CardBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 13
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.imageView?.image = UIImage(named: "up")
        cell?.textLabel?.text = "Testing"
        
        return cell ?? UITableViewCell()
    }

}
