//
//  AViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/29/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        createButton()
    }
    
    private func createButton() {
        
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        button.setTitle("Move to B", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(moveToView), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    @objc private func moveToView() {
        let bViewController = BViewController()
//        self.present(bViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(bViewController, animated: true)
        
    }
}
