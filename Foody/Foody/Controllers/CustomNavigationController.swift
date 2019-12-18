//
//  CustomNavigationController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/18/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override var preferredStatusBarStyle : UIStatusBarStyle {

        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }

        return .default
    }
  
}
