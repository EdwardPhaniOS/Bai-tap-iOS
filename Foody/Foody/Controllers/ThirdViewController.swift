//
//  ThirdViewController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        backButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5739015937, blue: 0, alpha: 1)
        backButton.layer.borderWidth = 2
        
        //layout Bottom view dynamically
    }
    
    //MARK: - Handle user action
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ThirdViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == collectionView {
            
            let x = targetContentOffset.pointee.x
            self.pageControl.currentPage = Int(x / view.frame.width)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOfThirdView", for: indexPath)
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension ThirdViewController: UICollectionViewDelegate {
    
}

extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let minSpace: CGFloat = 0
        let leftPadding: CGFloat = 0
        
        
        return CGSize(width: collectionView.frame.width - minSpace - leftPadding, height: collectionView.frame.height)
    }
}
