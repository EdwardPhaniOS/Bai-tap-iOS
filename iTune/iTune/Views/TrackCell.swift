//
//  TrackCell.swift
//  iTune
//
//  Created by Tan Vinh Phan on 12/23/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

protocol TrackCellDelegate {
    
    func downloadTapped(_ cell: TrackCell)
    
     func cancelTapped(_ cell: TrackCell)
}

class TrackCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    
   
    var delegate: TrackCellDelegate?
    
    
    @IBAction func downloadPressed(_ sender: UIButton) {
        
        delegate?.downloadTapped(self)
    }
    
}
