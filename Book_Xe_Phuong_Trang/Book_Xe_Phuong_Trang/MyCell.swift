//
//  MyCell.swift
//  Book_Xe_Phuong_Trang
//
//  Created by iMac_VTCA on 12/4/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //After iOS 13, we need to call 2 functions below so image/ content in cell fit in cell
    
    func getCellSize(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: targetSize.width, height: targetSize.height)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.getCellSize(targetSize)
    }
}
