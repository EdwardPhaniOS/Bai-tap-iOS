//
//  BViewController.swift
//  ViewControllerLifeCycle
//
//  Created by iMac_VTCA on 12/4/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("BViewControlle viewDidLoad \n")
    }
    

      override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print("BViewControlle viewWillAppear \n")
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         print("BViewControlle viewDidAppear \n")
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         print("BViewControlle viewWillDisappear \n")
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         print("BViewControlle viewDidDisappear \n")
     }
     
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
