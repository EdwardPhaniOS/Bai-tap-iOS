//
//  MyCollectionViewController.swift
//  Magazine
//
//  Created by Tan Vinh Phan on 11/27/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

private let minSpace: CGFloat = 20
private let leftAndRightPadding: CGFloat = 20

class MyCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 23
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MySmallCell
        smallCell.backgroundColor = UIColor.green
        
        //LAYOUT bang code:
        
//        let imageView: UIImageView = UIImageView(image: UIImage(named: img))
//        imageView.frame = cell.contentView.frame
//        imageView.contentMode = .scaleAspectFit
        
        
        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBigCell", for: indexPath) as! MyBigCell
        bigCell.backgroundColor = UIColor.blue
        
        //        if indexPath.row == 0 {
        //            return bigCell
        //        }
        
        return smallCell
    }
}

extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let visibleItems: CGFloat = 4.0
        
        let collectionViewWidth = collectionView.bounds.width
        
        let itemWidth = ((collectionViewWidth - leftAndRightPadding) - ((visibleItems - 1) * minSpace)) / visibleItems
        
        let itemHeight = itemWidth * 2
        
//        if indexPath.item == 0 {
//            let bigItemWidth = (3 * itemWidth) + (2 * minSpace)
//            return CGSize(width: bigItemWidth, height: itemHeight)
//
//        } else {
//            return CGSize(width: itemWidth, height: itemHeight)
//        }
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderCell", for: indexPath)
            
            return header
            
        default:
            print("Error: Unexpected element kind")
            return UICollectionViewCell()
        }
    }
}
