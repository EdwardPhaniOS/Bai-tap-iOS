//
//  MyCollectionViewController.swift
//  BaiTapUICollectionView
//
//  Created by Tan Vinh Phan on 11/20/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyCell"

class MyCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
        
        if let flowLayou = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayou.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.rowNumber = indexPath.row
        
        if indexPath.row % 2 == 0 {
            cell.contentView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else {
            cell.contentView.frame = CGRect(x: 0, y: 0, width: 60, height: 120)
            cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 60
        let heigh = 60

        if indexPath.row % 2 == 0 {
            return CGSize(width: width, height: heigh)
        } else {
            return CGSize(width: width, height: heigh*2)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}
