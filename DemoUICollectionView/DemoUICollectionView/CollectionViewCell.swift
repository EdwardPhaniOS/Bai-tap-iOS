//
//  CollectionViewCell.swift
//  DemoUICollectionView
//
//  Created by iMac_VTCA on 11/18/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    
    func minusButtonPressed(indexPath: IndexPath)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    
    var indexPath: IndexPath!
    var delegate: CollectionViewCellDelegate!
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        
        delegate?.minusButtonPressed(indexPath: indexPath)
    }
}
