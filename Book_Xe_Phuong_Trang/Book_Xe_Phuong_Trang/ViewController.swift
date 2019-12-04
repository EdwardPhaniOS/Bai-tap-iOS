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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCell
        
        let seatData = dataArray[indexPath.section][indexPath.item]
        
        if seatData == 0 {
             cell.backgroundColor = UIColor.white
            
        } else {
            let image = UIImage(named: "ic_chair_none")
            cell.imageView.image = image
        }
        
        return cell
     }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumn: CGFloat = CGFloat(dataArray[0].count)
        let minSpace: CGFloat = 8
        let leftAndRightPadding: CGFloat = 32
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let itemWidth = (screenWidth - leftAndRightPadding - ((numberOfColumn - 1) * minSpace)) / numberOfColumn
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
