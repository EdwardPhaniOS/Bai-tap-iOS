//
//  TaskCell.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/28/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit

protocol TaskCellDelegate {
    
    func remove(at cell: TaskCell)
    
    func doneTask(at cell: TaskCell)
}

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskIDLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: TaskCellDelegate?
    
    @IBAction func removeDidTapped(_ sender: UIButton) {
        delegate?.remove(at: self)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        delegate?.doneTask(at: self)
    }
    
}
