//
//  ViewController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/11/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
 
    var foods = FoodFactory.createFood()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 280
        
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
    }
}

extension FirstViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == featureCollectionView {
            
            let x = targetContentOffset.pointee.x
            self.pageControl.currentPage = Int(x / view.frame.width)
        }
    }
}

//MARK: - UITableViewDataSource

extension FirstViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TBVCellOfFirstVC", for: indexPath) as! TableViewCellOfFirstVC
        
        if indexPath.section == 0 {
            cell.sectionLabel.text = "Khuyến mãi"
        } else if indexPath.section == 1 {
            cell.sectionLabel.text = "Mới nhất"
        } else {
            cell.sectionLabel.text = "Nhiều người chọn nhất"
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension FirstViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCell", for: indexPath)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.contentView.layer.masksToBounds = true
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        let minSpace: CGFloat = 0
        
        return CGSize(width: collectionViewWidth - minSpace, height: collectionViewHeight)
    }
    
}


