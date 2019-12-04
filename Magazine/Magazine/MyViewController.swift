//
//  MyViewController.swift
//  Magazine
//
//  Created by iMac_VTCA on 11/27/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
    private let minSpace: CGFloat = 20
    private let leftAndRightPadding: CGFloat = 20
    
    let imagesName = ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView2.dataSource = self
        collectionView2.delegate = self
        
    }
    
}

extension MyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBigCell", for: indexPath) as! MyBigCell
            bigCell.backgroundColor = UIColor.blue
            bigCell.imageView.image = UIImage(named: imagesName[indexPath.item])
            
            return bigCell
        }
        
        let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySmallCell", for: indexPath) as! MySmallCell
        smallCell.backgroundColor = UIColor.green
        smallCell.imageView.image = UIImage(named: imagesName[indexPath.item])
        
        return smallCell
    }
    
    
}

extension MyViewController: UICollectionViewDelegate {
    
}

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let visibleItems: CGFloat = 4.0
           
           let collectionViewWidth = collectionView.bounds.width
           
           let itemWidth = ((collectionViewWidth - leftAndRightPadding) - ((visibleItems - 1) * minSpace)) / visibleItems
           
           let itemHeight = itemWidth * 1.5
           
           if indexPath.item == 0 {
            let bigItemWidth = collectionViewWidth - itemWidth - leftAndRightPadding - minSpace - 2.5
               return CGSize(width: bigItemWidth, height: itemHeight)

           } else {
               return CGSize(width: itemWidth, height: itemHeight)
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderCell", for: indexPath)
            
            return header
            
        default:
            print("Error: Unexpected element kind")
            return UICollectionViewCell()
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView2.collectionViewLayout.invalidateLayout()
    }
}
