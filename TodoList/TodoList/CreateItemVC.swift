//
//  CreateItemVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

let userDefault = UserDefaults.standard

class CreateItemVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let newItem = Item(
            uuid: UUID().uuidString,
            title: titleTextField.text!,
            description: descriptionTextField.text!,
            date: Date())
        
        do {
            let newItemData = try JSONEncoder().encode(newItem)
            userDefault.set(newItemData, forKey: newItem.uuid)
            
        } catch {
            print("Error: \(error)")
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}
