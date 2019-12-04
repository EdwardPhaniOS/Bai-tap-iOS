//
//  PushSecondViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/29/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class PushSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushToThirdScreen(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushToThirdScreen", sender: nil)
    }
    
    @IBAction func moveBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
