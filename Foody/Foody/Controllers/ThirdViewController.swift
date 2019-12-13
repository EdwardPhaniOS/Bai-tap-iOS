//
//  ThirdViewController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - UICollectionViewDataSource

extension ThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOfThirdView", for: indexPath)
        
        cell.layer.cornerRadius = 16
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension ThirdViewController: UICollectionViewDelegate {
    
}

extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let minSpace: CGFloat = 10
        let leftPadding: CGFloat = 10
        
        
        return CGSize(width: collectionView.frame.width - minSpace - leftPadding, height: collectionView.frame.height)
    }
}
