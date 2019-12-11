//
//  TableViewCellOfFirstVC.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/11/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class TableViewCellOfFirstVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionLabel: UILabel!
    
//    func getCellSize(_ targetSize: CGSize) -> CGSize {
//        return CGSize(width: targetSize.width, height: targetSize.height)
//    }
//    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        return self.getCellSize(targetSize)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func watchMorePressed(_ sender: UIButton) {
    }
    

}

//MARK: - UICollectionViewDataSource

extension TableViewCellOfFirstVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellOfFirstVC", for: indexPath)
        
        return cell
    }
}

extension TableViewCellOfFirstVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let visiableCell: CGFloat = 2
        let collectionViewWidth = collectionView.frame.width
        let minSpace: CGFloat = 16
        
        let itemWidth = (collectionViewWidth - minSpace) / visiableCell
        
        return CGSize(width: itemWidth , height: itemWidth * 1.2)
    }
}
