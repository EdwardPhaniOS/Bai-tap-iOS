//
//  UserCell.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/26/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit

protocol UserCellDelegate {
    
    func remove(at cell: UserCell)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var numberOfTaksLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var delegate: UserCellDelegate?
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        delegate?.remove(at: self)
    }
    
    
    
}
