//
//  FirstViewController.swift
//  Gesture
//
//  Created by iMac_VTCA on 12/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        
        //iOS 12 and before we need this line of code to solve confict between tap gesture and did select row at index path of Table View:
        tapGesture.cancelsTouchesInView = false //this mean: tap gesture wil cancel touch event if that position has another view
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyBoard() {
        self.view.endEditing(true)
    }
}

//MARK: - UITableViewDataSource

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = "cell \(indexPath.row)"
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toSecondView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
