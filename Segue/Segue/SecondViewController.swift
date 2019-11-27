//
//  SecondViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/27/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label.text = text
    }
    

    @IBAction func backToFirstScreenPressed(_ sender: Any) {
        
        //present modally -> can dismiss
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
