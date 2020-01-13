//
//  ViewController.swift
//  UsingCarthage
//
//  Created by iMac_VTCA on 1/3/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageView = UIImageView()
        let url = URL(string: "https://www.solarsystemscope.com/textures/download/8k_earth_daymap.jpg")
        imageView.kf.setImage(with: url)
        
        view.addSubview(imageView)
    }


}

