//
//  CustomCollectionViewCell.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getCellSize(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: targetSize.width, height: targetSize.height)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.getCellSize(targetSize)
    }
}
