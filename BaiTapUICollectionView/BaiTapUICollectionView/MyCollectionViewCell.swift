//
//  MyCollectionViewCell.swift
//  BaiTapUICollectionView
//
//  Created by Tan Vinh Phan on 11/20/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    var isHeightCalculated: Bool = false
    var rowNumber: Int?
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
            
//            setNeedsLayout()
//            layoutIfNeeded()
//
//            if let rowNumber = rowNumber {
//                if rowNumber % 2 == 0 {
//                    layoutAttributes.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
//                } else {
//                    layoutAttributes.frame = CGRect(x: 0, y: 0, width: 60, height: 120)
//                }
//            }
//            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
}
