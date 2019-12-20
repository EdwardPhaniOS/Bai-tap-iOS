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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellOfFirstVC", for: indexPath) as! CollectionViewCellOfFirstVC
        
        cell.setupAnimation()
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension TableViewCellOfFirstVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.contentView.layer.masksToBounds = true
        
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TableViewCellOfFirstVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let visiableCell: CGFloat = 2
        let screenWidth = UIScreen.main.bounds.width
        let minSpace: CGFloat = 10
        let leftAndRightPadding: CGFloat = 48
        
        let itemWidth = (screenWidth - (2*minSpace) - leftAndRightPadding) / visiableCell
        
        return CGSize(width: itemWidth , height: 200)
    }
}
