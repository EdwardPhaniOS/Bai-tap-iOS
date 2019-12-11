//
//  ViewController.swift
//  Foody
//
//  Created by Tan Vinh Phan on 12/11/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var featureCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 300
    }
}

//MARK: - UITableViewDataSource

extension FirstViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TBVCellOfFirstVC", for: indexPath)
        
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .blue
        }
        
        return cell
    }
}


