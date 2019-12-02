//
//  BViewController.swift
//  Segue
//
//  Created by iMac_VTCA on 11/29/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green
        createButton()
    }
    
    private func createButton() {
        
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        button.setTitle("Move to A", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(moveToView), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc private func moveToView() {
        //present - dismiss
        //self.dismiss(animated: true, completion: nil)
        
        //push - pop
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
