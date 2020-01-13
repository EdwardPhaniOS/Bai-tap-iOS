//
//  ItemCell.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    func setUpUI(title: String, description: String, dateCreated: String) {
        self.cellTitle.text = title
        self.cellDescription.text = description
        self.dateCreatedLabel.text = dateCreated
    }
}
