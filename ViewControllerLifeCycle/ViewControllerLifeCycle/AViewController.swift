//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by iMac_VTCA on 12/4/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class AViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("AViewControlle viewDidLoad \n")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AViewControlle viewWillAppear \n")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("AViewControlle viewDidAppear \n")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("AViewControlle viewWillDisappear \n")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("AViewControlle viewDidDisappear \n")
    }
    
}

