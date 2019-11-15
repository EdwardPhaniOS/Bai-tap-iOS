//
//  ViewController.swift
//  MyPageView
//
//  Created by iMac_VTCA on 11/15/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    private var myPageController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        let selectedIndex = sender.selectedSegmentIndex
        myPageController.setViewController(with: selectedIndex)

    }
    
    //embed segue -> prepare for segue is called
    //active segue -> prepare for segue is called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? PageViewController {
            self.myPageController = pageController
            self.myPageController.customDelegate = self
        }
    }
}

extension ViewController: PageViewControllerDelegate {
    func didUpdateSegment(with index: Int) {
        mySegment.selectedSegmentIndex = index
    }
}
