//
//  XibViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 12/2/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class XibViewController: UIViewController {

    @IBOutlet weak var pushToViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func pushToFirstView(_ sender: UIButton) {

        //push, pop need to use: storyboard init with id, init with nib name
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(identifier: "ViewController")
        self.navigationController?.pushViewController(firstVC, animated: true)
    }


}
