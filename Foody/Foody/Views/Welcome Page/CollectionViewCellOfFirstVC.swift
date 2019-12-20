//
//  CollectionViewCellOfFirstVC.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/11/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class CollectionViewCellOfFirstVC: UICollectionViewCell {
    
    func getCellSize(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: targetSize.width, height: targetSize.height)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.getCellSize(targetSize)
    }
    
    func setupAnimation() {
        
        // add shadow on cell
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
}
