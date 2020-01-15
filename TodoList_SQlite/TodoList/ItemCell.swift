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
    @IBOutlet weak var currentLocation: UILabel!
    
    func setUpUI(title: String, description: String, dateCreated: String, location: Location?) {
        self.cellTitle.text = title
        self.cellDescription.text = description
        self.dateCreatedLabel.text = dateCreated
        
        if let location = location {
            currentLocation.isHidden = false
            currentLocation.text = "\(location.latitude), \(location.longtitude)"
        } else {
            currentLocation.isHidden = true
        }
    }
}
