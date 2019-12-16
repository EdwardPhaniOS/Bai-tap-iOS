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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellOfFirstVC", for: indexPath)
        
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
}

extension TableViewCellOfFirstVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let visiableCell: CGFloat = 2.1
        let collectionViewWidth = collectionView.frame.width
        let minSpace: CGFloat = 10
        let leftPadding: CGFloat = 5
        
        let itemWidth = (collectionViewWidth - minSpace - leftPadding) / visiableCell
        
        return CGSize(width: itemWidth , height: itemWidth * 1.4)
    }
}
