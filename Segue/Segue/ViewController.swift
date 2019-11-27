//
//  ViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/27/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func toSecondScreenPressed(_ sender: UIButton) {
        
        let text = "abc"
        
        self.performSegue(withIdentifier: "ToSecondScreen", sender: text)
    }
    
    @IBAction func backToRootScreen(segue: UIStoryboardSegue) {
        //do something
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSecondScreen" {
            if let vc = segue.destination as? SecondViewController {
                vc.text = sender as! String
            }
        }
    }
}

