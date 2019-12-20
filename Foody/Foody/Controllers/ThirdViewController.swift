//
//  ThirdViewController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

let bottomVisiableCell = 4


class ThirdViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionViewOfTopView: UICollectionView!
    @IBOutlet weak var collectionViewOfBottomView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOfTopView.dataSource = self
        collectionViewOfTopView.delegate = self
        
        collectionViewOfBottomView.dataSource = self
        collectionViewOfBottomView.delegate = self
        
        backButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5739015937, blue: 0, alpha: 1)
        backButton.layer.borderWidth = 2
        
        //layout Bottom view dynamically

        if bottomVisiableCell == 0 {
            
            let constraints = [
                bottomView.heightAnchor.constraint(equalToConstant: 56)
            ]
            
            NSLayoutConstraint.activate(constraints)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Handle user action
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ThirdViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == collectionViewOfTopView {
            
            let x = targetContentOffset.pointee.x
            self.pageControl.currentPage = Int(x / view.frame.width)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewOfTopView {
            return 5
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewOfTopView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOfTopView", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOfBottomView", for: indexPath)
            return cell
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension ThirdViewController: UICollectionViewDelegate {
    
}

extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewOfTopView {
            let minSpace: CGFloat = 0
            let leftPadding: CGFloat = 0
            
            return CGSize(width: collectionView.frame.width - minSpace - leftPadding, height: collectionView.frame.height)
            
        } else {
            if bottomVisiableCell == 0 {
                return CGSize(width: 0, height: 0)
            } else {
                return CGSize(width: 80, height: 80)
            }
        }
    }
}
