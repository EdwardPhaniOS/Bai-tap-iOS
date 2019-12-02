//
//  PickDateViewController.swift
//  BlueBrokers
//
//  Created by iMac_VTCA on 12/2/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class PickDateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func outscreenPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        print(sender.date)
    }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        print("Submit pressed")
    }
    
}
