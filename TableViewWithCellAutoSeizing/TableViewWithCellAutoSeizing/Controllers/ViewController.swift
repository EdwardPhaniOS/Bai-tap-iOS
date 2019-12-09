//
//  ViewController.swift
//  TableViewWithCellAutoSeizing
//
//  Created by iMac_VTCA on 12/9/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var contents: [Content] = []
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToAddContent", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddContent" {
            if let addContentVC = segue.destination as? AddContentViewController {
                addContentVC.delegate = self
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //                guard let cell = tableView
        //                    .dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyCell else{ return UITableViewCell() }
        //
        //                cell.titleLabel.text = contents[indexPath.row].title
        //                cell.descriptionLabel.text = contents[indexPath.row].description
        //
        //                return cell
        
        let cell = MyCell.createCell(tableView, cellForRowAt: indexPath)
        cell.titleLabel.text = contents[indexPath.row].title
        cell.descriptionLabel.text = contents[indexPath.row].description
        
        return cell
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        //
        //        let rectTitle = CGRect(x: 0, y: 10, width: tableView.bounds.size.width, height: 100)
        //        let labelTitle = UILabel(frame: rectTitle)
        //        labelTitle.textColor = .black
        //        labelTitle.font = UIFont.boldSystemFont(ofSize: 17)
        //        labelTitle.textAlignment = .left
        //        labelTitle.numberOfLines = 0
        //
        //        labelTitle.text = contents[indexPath.row].title
        //        labelTitle.sizeToFit()
        //        labelTitle.backgroundColor = UIColor.blue
        //
        //        let labelTitleHeight = labelTitle.frame.height
        //
        //        let rectDescription = CGRect(x: 0, y: labelTitleHeight + 15, width: tableView.bounds.size.width, height: 100)
        //        let labelDescription = UILabel(frame: rectDescription)
        //        labelDescription.textColor = .black
        //        labelDescription.font = UIFont.systemFont(ofSize: 17)
        //        labelDescription.textAlignment = .left
        //        labelDescription.numberOfLines = 0
        //
        //        labelDescription.text = contents[indexPath.row].description
        //        labelDescription.sizeToFit()
        //        labelDescription.backgroundColor = UIColor.green
        //
        //        cell.addSubview(labelTitle)
        //        cell.addSubview(labelDescription)
        //
        //        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        //Get Label Title height
    //
    //        let rect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 100)
    //        let labelTitle = UILabel(frame: rect)
    //        labelTitle.textColor = .black
    //        labelTitle.font = UIFont.boldSystemFont(ofSize: 17)
    //        labelTitle.textAlignment = .left
    //        labelTitle.numberOfLines = 0
    //
    //        labelTitle.text = contents[indexPath.row].title
    //        labelTitle.sizeToFit()
    //
    //        let labelTitleHeight = labelTitle.frame.height
    //
    //        //Get Label Description height
    //
    //        let labelDescription = UILabel(frame: rect)
    //        labelDescription.textColor = .black
    //        labelDescription.font = UIFont.systemFont(ofSize: 17)
    //        labelDescription.textAlignment = .left
    //        labelDescription.numberOfLines = 0
    //
    //        labelDescription.text = contents[indexPath.row].description
    //        labelDescription.sizeToFit()
    //
    //        let labelDescriptionHeight = labelTitle.frame.height
    //
    //        let minSpace: CGFloat = 5
    //        let topAndBottonPadding: CGFloat = 20
    //
    //        return topAndBottonPadding + labelTitleHeight + minSpace + labelDescriptionHeight
    //    }
    
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ViewController: AddContentViewControllerDelegate {
    
    func addNew(content: Content) {
        self.contents.append(content)
    }
}


