//
//  PushFourthViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/29/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class PushFourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backToSecondScreen(_ sender: UIButton) {
        
        guard let totalVC = navigationController?.viewControllers.count else { return }
        
        //If there are more than 1 VC in array, access second VC in array
        if totalVC > 1 {
            if let vc = navigationController?.viewControllers[1] {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
}
