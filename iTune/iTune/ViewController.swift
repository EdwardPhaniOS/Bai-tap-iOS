//
//  ViewController.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.tableFooterView = UIView()
        
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = #colorLiteral(red: 0.5094058514, green: 0.7023435831, blue: 1, alpha: 1)
    
        tableView.dataSource = self
        tableView.delegate = self
        
        let networkManager = NetworkManager()
        tracks = networkManager.requestAPI()
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackCell
        cell.backgroundColor = .clear
        cell.songNameLabel.text = tracks[indexPath.row].trackName
        cell.artistLabel.text = tracks[indexPath.row].artistName
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



