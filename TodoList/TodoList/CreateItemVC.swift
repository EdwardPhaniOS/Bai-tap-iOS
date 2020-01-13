//
//  CreateItemVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

let userDefault = UserDefaults.standard

protocol CreateItemVCDelegate {
    func itemDidAdded()
}

class CreateItemVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var createItemDelegate: CreateItemVCDelegate?
    var arrayItems = [Item]()
    var keys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        let newItem = Item(
            uuid: UUID().uuidString,
            title: titleTextField.text!,
            description: descriptionTextField.text!,
            date: Date())
        
        keys.append(newItem.uuid)
        
        do {
            let newItemData = try JSONEncoder().encode(newItem)
            userDefault.set(keys, forKey: "itemKeys")
            userDefault.set(newItemData, forKey: newItem.uuid)
            
            createItemDelegate?.itemDidAdded()
            
        } catch {
            print("Error: \(error)")
        }
    }

}
