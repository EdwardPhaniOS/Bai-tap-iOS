//
//  ViewController.swift
//  Book_Xe_Phuong_Trang
//
//  Created by Tan Vinh Phan on 12/4/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var dataArray = [
                 [1, 0, 1, 0, 1],
                 [1, 0, 1, 0, 1],
                 [1, 0, 1, 0, 1],
                 [1, 0, 1, 0, 1],
                 [1, 1, 1, 1, 1]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
        let seatData = dataArray[indexPath.section][indexPath.item]
        
        if seatData == 0 {
             cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.green
        }
        
        return cell
     }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumn: CGFloat = 5
        let minSpace: CGFloat = 8
        
        
        let collectionViewWidth = self.collectionView.bounds.width
        
        let itemWidth = (collectionViewWidth - ((numberOfColumn - 1) * minSpace)) / numberOfColumn
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
