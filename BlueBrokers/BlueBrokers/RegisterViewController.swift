//
//  RegisterViewController.swift
//  BlueBrokers
//
//  Created by Tan Vinh Phan on 12/4/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            sender.setTitle(" 🔘 Male", for: .normal)
            femaleButton.setTitle(" ⃝ Female", for: .normal)
        } else {
            sender.setTitle(" 🔘 Female", for: .normal)
            maleButton.setTitle(" ⃝ Male", for: .normal)
        }
        
    }
}
