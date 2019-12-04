//
//  ViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/27/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "First Screen"
    }


    @IBAction func toSecondScreenPressed(_ sender: UIButton) {
        
        let text = "abc"
        
        self.performSegue(withIdentifier: "ToSecondScreen", sender: text)
    }
    
    @IBAction func backToRootScreen(segue: UIStoryboardSegue) {
        //do something
    }
    
    @IBAction func moveToScreen2UsingCode(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController {
            //Presents a view controller modally.
            self.present(secondVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func pushToFirstScreen(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushToFirstScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSecondScreen" {
            if let vc = segue.destination as? SecondViewController {
                vc.text = sender as! String
            }
        }
    }
}

