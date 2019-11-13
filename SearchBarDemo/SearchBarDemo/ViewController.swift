//
//  ViewController.swift
//  MySearchBar
//
//  Created by iMac_VTCA on 11/13/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

enum Category: String {
    case all = "All"
    case chocolate = "Chocolate"
    case hard = "Hard"
    case other = "Other"
}

struct Candy {
    let name: String
    let category: Category
    
    init(with dictionary: [String: String]) {
        
        self.name = dictionary["name"] ?? ""
        
        let cate = dictionary["category"] ?? ""
        
        switch cate {
        case "Chocolate":
            self.category = .chocolate
        case "Hard":
            self.category = .hard
        case "Other":
            self.category = .other
        default:
            self.category = .all
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var myTableView: UITableView!
    var arrayItem: [Candy] = []
    var arrayItemConstant: [Candy] = []
    
    lazy var arrayCategory: [Category] = [.all, .chocolate, .hard, .other]
    
    var currentScope = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        mySearchBar.delegate = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        mySearchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        createArrayCandy()
        
    }
    
    
    private func createArrayCandy() {
        
        let array = [
            [ "name": "Chocolate Bar", "category": "Chocolate"    ],
            [ "name": "Chocolate Chip", "category": "Chocolate"   ],
            [ "name": "Dark Chocolate", "category": "Chocolate"   ],
            [ "name": "Chocolate Coin", "category": "Chocolate"   ],
            [ "name": "Chocolate Egg", "category": "Chocolate"    ],
            [ "name": "Lollipop", "category": "Hard"              ],
            [ "name": "Jaw Breaker", "category": "Hard"           ],
            [ "name": "Toffee Apple", "category": "Hard"          ],
            [ "name": "Caramel", "category": "Other"              ],
            [ "name": "Sour Chew", "category": "Other"            ],
            [ "name": "Gummi Bear", "category": "Other"           ],
            [ "name": "Candy Floss", "category": "Other"          ],
            [ "name": "Jelly Beans", "category": "Other"          ],
            [ "name": "Liquorice", "category": "Other"            ],
        ]
        
        for item in array {
            let candy = Candy(with: item)
            arrayItem.append(candy)
            arrayItemConstant.append(candy)
        }
        
        myTableView.reloadData()
    }
    
    func filterItem(with searchText: String) {
        
        var category = Category.all
        switch currentScope {
        case 0:
            category = Category.all
        case 1:
            category = Category.chocolate
        case 2:
            category = Category.hard
        case 3:
            category = Category.other
        default:
            category = Category.other
        }
        
        if searchText == "" {
            arrayItem = arrayItemConstant
        } else {
            
            if category == .all {
                arrayItem = arrayItemConstant.filter({ (candy) -> Bool in
                    return candy.name.lowercased().contains(searchText.lowercased())
                })
            } else {
                arrayItem = arrayItemConstant.filter({ (candy) -> Bool in
                    return candy.name.lowercased().contains(searchText.lowercased())
                        && candy.category == category
                })
            }
        }
        
        myTableView.reloadData()
    }
}



extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filterItem(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searhc button")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel button")
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
        currentScope = selectedScope
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let item = arrayItem[indexPath.row]
        cell.textLabel?.text = "\(item.name)  -  \(item.category.rawValue)"
        return cell
    }
    
    
}

