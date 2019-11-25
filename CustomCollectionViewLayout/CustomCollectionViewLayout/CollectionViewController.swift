//
//  CollectionViewController.swift
//  CustomCollectionViewLayout
//
//  Created by Tan Vinh Phan on 11/25/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return collectionViewLayout as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    
    struct Model {
        var index: Int
        var isBig: Bool
    }
    
    private let dataSet = [Model(index: 1, isBig: true),
                           Model(index: 2, isBig: false),
                           Model(index: 3, isBig: false),
                           Model(index: 4, isBig: true),
                           Model(index: 5, isBig: false),
                           Model(index: 6, isBig: false),
                           Model(index: 7, isBig: true),
                           Model(index: 8, isBig: false),
                           Model(index: 9, isBig: false),
                           Model(index: 10, isBig: true),
                           Model(index: 11, isBig: false),
                           Model(index: 12, isBig: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 2
//        self.customCollectionViewLayout?.cellPadding = 30
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? UICustomCollectionViewCell
        cell?.label.text = "\(dataSet[indexPath.row].index)"
        cell?.backgroundColor = UIColor.systemBlue
        
        return cell ?? UICollectionViewCell()
    }
}

extension CollectionViewController : CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAt indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        
        let heightSizes = [100,200]
        return CGFloat(heightSizes[dataSet[indexPath.row].isBig ? 1 : 0])
    }
}

